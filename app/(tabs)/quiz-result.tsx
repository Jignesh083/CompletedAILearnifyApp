import { Audio } from "expo-av";
import { useLocalSearchParams, useRouter } from "expo-router";
import LottieView from 'lottie-react-native';
import { useEffect, useRef, useState } from "react";
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, Text, View } from "react-native";
import { API } from "../../config/api";

export default function QuizResult(){

 const router = useRouter();
 const params = useLocalSearchParams();

 const attemptId = params.attempt_id;

 const scoreParam = Number(params.score || 0);
 const totalParam = Number(params.total || 0);

 const [review,setReview] = useState<any[]>([]);
 const [loading,setLoading] = useState(true);
const soundRef = useRef<Audio.Sound | null>(null);
 useEffect(()=>{

  const load = async ()=>{

   try{

    const res = await fetch(`${API}/quiz/attempt/${attemptId}`);
    const text = await res.text();

    if(text.startsWith("<")){
      console.log("Server returned HTML → skipping review load");
      setReview([]);
      return;
    }

    const data = JSON.parse(text);
    setReview(Array.isArray(data) ? data : []);

   }catch(e){
    console.log("RESULT LOAD ERROR",e);
   }finally{
    setLoading(false);
   }

  };

  if(attemptId){
    load();
  }

 },[attemptId]);


 useEffect(() => {

  const playResultSound = async () => {

    try {

      const percentage =
        totalParam > 0
          ? (scoreParam / totalParam) * 100
          : 0;

      let soundFile;

      if (percentage >= 80) {

        soundFile = require("../../assets/sounds/victory.mp3");

      } else if (percentage >= 50) {

        soundFile = require("../../assets/sounds/success.mp3");

      } else {

        soundFile = require("../../assets/sounds/try-again.mp3");

      }

      const { sound } =
        await Audio.Sound.createAsync(soundFile);

      soundRef.current = sound;

      await sound.playAsync();

    } catch (e) {

      console.log("SOUND ERROR:", e);

    }

  };

  playResultSound();

  return () => {
    if (soundRef.current) {
      soundRef.current.unloadAsync();
    }
  };

}, []);

 const total = totalParam;

 if(loading){
  return(
    <View style={styles.loader}>
      <ActivityIndicator size="large" color="#123C7B"/>
    </View>
  );
 }

 return(
  <ScrollView style={styles.container}>

   {/* Result Card */}
   <View style={styles.card}>
    <Text style={styles.title}>Quiz Result</Text>
    <Text style={styles.score}>{scoreParam} / {total}</Text>
    <LottieView
  source={require('../../assets/animations/Fireworks.json')}
  autoPlay
  loop={true}
  style={styles.celebrationAnimation}
/>
   </View>

   {/* Review */}
   {review.map((q,index)=>(
    <View key={index} style={[
      styles.qCard,
      q.is_correct ? styles.correct : styles.wrong
    ]}>
      <Text style={styles.qText}>{q.question}</Text>
      <Text style={styles.optText}>Your Answer: {q.option_text}</Text>
      <Text style={styles.status}>
        {q.is_correct ? "Correct ✅" : "Wrong ❌"}
      </Text>
    </View>
   ))}

   {/* 🎉 NEW CONGRATS SECTION */}
   <View style={styles.congratsCard}>
     <Text style={styles.emoji}>🎉</Text>

     <Text style={styles.congratsTitle}>Congratulations!</Text>

     <Text style={styles.congratsText}>
       You’ve successfully completed this quiz with great effort and dedication. 🚀
     </Text>

     <Text style={styles.congratsSub}>
       Keep going — you're getting closer to mastery!
     </Text>

     <Pressable
       style={styles.btn}
       onPress={()=>router.replace("/")}
     >
       <Text style={styles.btnText}>Attempt Another Quiz</Text>
     </Pressable>
   </View>

  </ScrollView>
 );
}

const styles = StyleSheet.create({

container:{
  flex:1,
  backgroundColor:"#F5F7FB",
  padding:20
},

card:{
  marginTop:30,
  backgroundColor:"#123C7B",
  padding:24,
  borderRadius:20,
  alignItems:"center",
  marginBottom:20,

  shadowColor:"#123C7B",
  shadowOpacity:0.3,
  shadowRadius:8,
  elevation:4
},

title:{
  color:"#fff",
  fontSize:20,
  fontWeight:"600"
},
celebrationAnimation:{
  width:180,
  height:180,
  marginTop:10
},
score:{
  color:"#fff",
  fontSize:42,
  fontWeight:"800",
  marginTop:8
},

qCard:{
  padding:16,
  borderRadius:14,
  marginBottom:12,

  shadowColor:"#000",
  shadowOpacity:0.04,
  shadowRadius:5,
  elevation:2
},

correct:{
  backgroundColor:"#ECFDF5",
  borderLeftWidth:4,
  borderLeftColor:"#22C55E"
},

wrong:{
  backgroundColor:"#FEF2F2",
  borderLeftWidth:4,
  borderLeftColor:"#EF4444"
},

qText:{
  fontSize:15,
  fontWeight:"600",
  color:"#222"
},

optText:{
  marginTop:6,
  fontSize:14,
  color:"#555"
},

status:{
  marginTop:6,
  fontWeight:"700",
  fontSize:13
},

/* 🎉 NEW STYLES */
congratsCard:{
  marginTop:60,
  backgroundColor:"#ffffff",
  padding:22,
  borderRadius:18,
  alignItems:"center",

  shadowColor:"#000",
  shadowOpacity:0.05,
  shadowRadius:8,
  elevation:3
},

emoji:{
  fontSize:40,
  marginBottom:8
},

congratsTitle:{
  fontSize:20,
  fontWeight:"700",
  color:"#123C7B",
  marginBottom:6
},

congratsText:{
  fontSize:14,
  color:"#444",
  textAlign:"center",
  lineHeight:20
},

congratsSub:{
  marginTop:6,
  fontSize:13,
  color:"#777",
  textAlign:"center"
},

btn:{
  marginTop:18,
  backgroundColor:"#123C7B",
  padding:14,
  borderRadius:12,
  alignItems:"center",
  width:"100%"
},

btnText:{
  color:"#fff",
  fontWeight:"700",
  fontSize:15,
  letterSpacing:0.5
},

loader:{
  flex:1,
  justifyContent:"center",
  alignItems:"center",
  backgroundColor:"#F5F7FB"
}

});