import AsyncStorage from '@react-native-async-storage/async-storage';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { useEffect, useReducer, useState } from 'react';
import {
  ActivityIndicator,
  Alert,
  BackHandler,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { getQuizByTopic } from '../../services/questionRepository';

// 🔥 CHANGE AFTER DEPLOY
const API = "https://ailearnifyapp-tbrt.onrender.com";

/* ================= SHUFFLE ================= */

const shuffleArray = <T,>(arr: T[]): T[] => {
  const copy = [...arr];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
};

const shuffleQuestion = (q:any) => {

  const normalized = q.options.map((o:any)=>({
    ...o,
    is_correct:
      o.is_correct === true ||
      o.is_correct === 1 ||
      o.is_correct === "1" ||
      o.is_correct === "true"
  }));

  const shuffled = shuffleArray(normalized);

  return {
    id: q.id,
    question: q.question,
    options: shuffled
  };
};

/* ================= REDUCER ================= */

const initialState = {
  current: 0,
  selected: null,
  finished: false,
};

function reducer(state:any, action:any){
  switch(action.type){
    case 'SELECT':
      return { ...state, selected: action.payload };
    case 'NEXT':
      return { ...state, current: state.current + 1, selected:null };
    case 'FINISH':
      return { ...state, finished:true };
    case 'RESET':
      return initialState;
    default:
      return state;
  }
}

export default function QuizScreen(){
  const router = useRouter();
  const params = useLocalSearchParams();

const topicKey = params.topicKey as string;
console.log("FINAL topicKey:", topicKey);
  const title = params.title as string;
  const safeTitle = title || "Quiz";

  const [state,dispatch] = useReducer(reducer,initialState);
  const {current,selected,finished} = state;

  const [quiz,setQuiz] = useState<any[]>([]);
  const [loading,setLoading] = useState(true);
  const [error,setError] = useState("");

  const [answers,setAnswers] = useState<any[]>([]);
  const [attemptId,setAttemptId] = useState<number | null>(null);

  const [showAnswer,setShowAnswer] = useState(false);



const loadQuiz = async ()=>{
  const userId = await AsyncStorage.getItem("user_id");

  setLoading(true);
  setError("");   // ✅ reset error

  try{

    const attemptRes = await fetch(`${API}/quiz/start`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        user_id: userId,
        topic_key: topicKey
      })
    });

    const attemptData = await attemptRes.json();

    if (!attemptData.success) {
      throw new Error("Attempt failed");
    }

    setAttemptId(attemptData.attempt_id);

    const raw = await getQuizByTopic(topicKey, 1, 20);

    if(!raw || raw.length === 0){
      throw new Error("No quiz data");
    }

    const processed = raw.slice(0,20).map(shuffleQuestion);

    setQuiz(processed);
    dispatch({type:'RESET'});

  }catch(e){
    console.log("LOAD ERROR:", e);
    setError("Unable to load quiz. Please check your internet connection.");
    setQuiz([]);
  }

  setLoading(false);
};

  useEffect(()=>{
    loadQuiz();
  },[topicKey]);

  useEffect(()=>{
    const sub = BackHandler.addEventListener('hardwareBackPress',()=>{
      router.back();
      return true;
    });
    return ()=>sub.remove();
  },[]);

  if(loading){
    return (
      <View style={[styles.container,{justifyContent:'center'}]}>
        <ActivityIndicator size="large" color="#123C7B"/>
      </View>
    );
  }


  if(error){
  return (
    <View style={[styles.container,{justifyContent:'center', alignItems:'center'}]}>
      <Text style={{textAlign:'center'}}>
        {error}
      </Text>
    </View>
  );
}

  if(!quiz.length){
    return (
      <View style={[styles.container,{justifyContent:'center'}]}>
        <Text>No Questions Found</Text>
      </View>
    );
  }

  if(finished){
    return (
      <View style={styles.container}>
        <Text style={styles.title}>Submitting...</Text>
      </View>
    );
  }

  const question = quiz[current];

  const correctIndex = question.options.findIndex(
    (o:any)=> o.is_correct === true
  );

  const handleNext = async ()=>{

    if(selected === null){
      Alert.alert("Select option");
      return;
    }

    const selectedOption = question.options[selected];

    const updatedAnswers = [
      ...answers,
      {
        question_id: question.id,
        option_id: selectedOption.id
      }
    ];

    setAnswers(updatedAnswers);
    setShowAnswer(false);

    if(current + 1 < quiz.length){
      dispatch({type:'NEXT'});
    }else{

      if(!attemptId){
        Alert.alert("Error", "Attempt not started");
        return;
      }

      dispatch({type:'FINISH'});

      try{

        const res = await fetch(`${API}/quiz/submit-attempt`,{
          method:"POST",
          headers:{ "Content-Type":"application/json" },
          body: JSON.stringify({
            attempt_id: attemptId,
            answers: updatedAnswers
          })
        });

        const data = await res.json();

const scoreFromServer =
  data?.data?.score || data?.score;

router.replace({
  pathname:"/quiz-result",
  params:{
    score: scoreFromServer,
    total:quiz.length,
    attempt_id:attemptId
  }
});

      }catch(e){
        Alert.alert("Network Error Submit Failed");
      }

    }
  };

  return (
    <View style={styles.container}>

      <Text style={styles.title}>📝 {safeTitle}</Text>

      <Text style={styles.progress}>
        Question {current+1} / 20
      </Text>

      <Text style={styles.question}>{question.question}</Text>

      {question.options.map((opt:any,index:number)=>{

        let bgColor = '#F1F5FB';

        if(showAnswer){

          if(index === correctIndex){
            bgColor = '#C8E6C9';
          }
          else if(selected === index){
            bgColor = '#FFCDD2';
          }

        }
        else if(selected === index){
          bgColor = '#CFE0FF';
        }

        return (
          <Pressable
            key={`${question.id}_${opt.id}`}
            style={[styles.option,{backgroundColor:bgColor}]}
            onPress={()=>{
              if(showAnswer) return;
              dispatch({type:'SELECT',payload:index});
              setShowAnswer(true);
            }}
          >
            <Text style={styles.optionText}>
              {String(opt.option_text)}
            </Text>
          </Pressable>
        );

      })}

      <Pressable style={styles.nextBtn} onPress={handleNext}>
        <Text style={styles.nextText}>
          {current+1===quiz.length ? "Submit Quiz" : "Next"}
        </Text>
      </Pressable>

    </View>
  );
}

const styles = StyleSheet.create({

container:{
  flex:1,
  backgroundColor:'#F5F7FB',
  padding:20,
  paddingTop:40
},

title:{
  marginTop:10,
  fontSize:20,
  fontWeight:'700',
  marginBottom:10,
  color:'#111'
},

progress:{
  fontSize:13,
  marginBottom:14,
  color:'#666'
},

question:{
  fontSize:17,
  fontWeight:'600',
  marginBottom:18,
  color:'#222',
  lineHeight:24
},

option:{
  padding:16,
  borderRadius:12,
  backgroundColor:'#fff',
  marginBottom:12,

  // shadow
  shadowColor:"#000",
  shadowOpacity:0.04,
  shadowRadius:5,
  elevation:2
},

optionText:{
  fontSize:15,
  fontWeight:'500',
  color:'#333'
},

nextBtn:{
  marginTop:20,
  backgroundColor:'#123C7B',
  padding:16,
  borderRadius:12,
  alignItems:'center',

  shadowColor:"#123C7B",
  shadowOpacity:0.25,
  shadowRadius:6,
  elevation:3
},

nextText:{
  color:'#fff',
  fontWeight:'600',
  fontSize:16,
  letterSpacing:0.5
}

});