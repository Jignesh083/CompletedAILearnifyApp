import AsyncStorage from "@react-native-async-storage/async-storage";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useEffect, useReducer, useState } from "react";
import {
  ActivityIndicator,
  Alert,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from "react-native";
import { API } from "../../config/api"; // ✅ GLOBAL API
const topicMap: Record<string, string> = {
  reinforcement: "ReinforcementLearning",
  machine: "MachineLearning",
  deep: "DeepLearning"
};
const initialState = {
  loading: true,
  questions: [],
  current: 0,
  answers: []
};

function reducer(state:any, action:any){

  switch(action.type){

    case "SET_QUIZ":
      return {
        ...state,
        loading:false,
        questions: action.payload || []
      };

    case "ANSWER":

      const updated = [...state.answers];
      updated[state.current] = action.payload;

      return {
        ...state,
        answers: updated,
        current: state.current + 1
      };

    default:
      return state;
  }
}

export default function DailyQuiz(){
  
  const router = useRouter();
  const params = useLocalSearchParams();
const subject = String(params.subject || params.course || "");
  const [state, dispatch] = useReducer(reducer, initialState);
  const [submitting, setSubmitting] = useState(false);

  const {loading,questions,current,answers} = state;

  /* ================= FETCH ================= */

  useEffect(()=>{

    if(!subject) return;

    const load = async ()=>{

      try{

        const res = await fetch(`${API}/daily-quiz/${subject.toLowerCase()}`);

        const data = await res.json();

        dispatch({
          type:"SET_QUIZ",
          payload:data
        });

      }catch(e){

        Alert.alert("Error","Quiz load failed");

        dispatch({
          type:"SET_QUIZ",
          payload:[]
        });

      }

    };

    load();

  },[subject]);

  /* ================= SUBMIT ================= */

const submitQuiz = async (finalAnswers = answers) => {

  setSubmitting(true);

  try {

    const storedId = await AsyncStorage.getItem("user_id");

    if (!storedId) {
      Alert.alert("Error", "User not logged in");
      return;
    }

    const finalTopic = questions[0]?.topic_key;

    console.log("SUBJECT =", subject);
    console.log("FINAL TOPIC =", finalTopic);

    if (!finalTopic) {
      Alert.alert("Error", "Topic not found");
      return;
    }

    const startRes = await fetch(`${API}/quiz/start`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        user_id: storedId,
        topic_key: finalTopic
      })
    });

    const startData = await startRes.json();

    console.log("ATTEMPT START:", startData);

    if (!startData.success || !startData.attempt_id) {
      Alert.alert("Error", "Failed to start attempt");
      return;
    }

    const attemptIdLocal = startData.attempt_id;

    const formatted = finalAnswers.map(
      (optId: number, index: number) => ({
        question_id: questions[index].id,
        option_id: optId
      })
    );

    const res = await fetch(`${API}/quiz/submit-attempt`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        attempt_id: attemptIdLocal,
        answers: formatted
      })
    });

    const data = await res.json();

    console.log("SUBMIT RESPONSE:", data);

    router.replace({
      pathname: "/quiz-result",
      params: {
        attempt_id: String(attemptIdLocal),
        score: data.score || 0,
        total: questions.length
      }
    });

  } catch (e) {

    console.log("SUBMIT ERROR:", e);
    Alert.alert("Error", "Submit failed");

  } finally {

    setSubmitting(false);

  }

};

  /* ================= STATES ================= */

  if(loading){
    return (
      <View style={styles.center}>
        <ActivityIndicator size="large"/>
      </View>
    );
  }

  if (submitting) {
  return (
    <View style={styles.center}>
      <ActivityIndicator size="large" color="#123C7B" />

      <Text
        style={{
          marginTop: 15,
          fontSize: 16,
          fontWeight: "600",
          color: "#123C7B"
        }}
      >
        Submitting quiz...
      </Text>
    </View>
  );
}

  if(!questions.length){
    return (
      <View style={styles.center}>
        <Text>No Daily Quiz Available</Text>
      </View>
    );
  }

  if(current >= questions.length){
    return null;
  }

  const q = questions[current];

  /* ================= UI ================= */

  return (
    <View style={styles.container}>

      <Text style={styles.progress}>
        Question {current+1} / {questions.length}
      </Text>

      <Text style={styles.question}>
        {q.question}
      </Text>

      {q.options?.map((opt:any)=>(

        <TouchableOpacity
          key={opt.id}
          style={styles.option}
          onPress={()=>{

            const updatedAnswers = [...answers];
            updatedAnswers[current] = opt.id;

            if(current === questions.length - 1){

              submitQuiz(updatedAnswers);

            }else{

              dispatch({
                type:"ANSWER",
                payload: opt.id
              });

            }

          }}
        >
          <Text>
            {opt.option_text || opt.text}
          </Text>
        </TouchableOpacity>

      ))}

    </View>
  );
}

const styles = StyleSheet.create({
  container:{ flex:1, padding:20, marginTop:30, backgroundColor:"#F5F7FB" },
  question:{ fontSize:18, marginBottom:20 },
  progress:{
    fontSize:14,
    marginBottom:10,
    color:"#666"
  },
  option:{
    padding:15,
    backgroundColor:"#eee",
    marginBottom:10,
    borderRadius:8
  },
  center:{
    flex:1,
    justifyContent:"center",
    alignItems:"center"
  }
});