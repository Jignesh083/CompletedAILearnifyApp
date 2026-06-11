import { Ionicons } from '@expo/vector-icons';

import AsyncStorage from "@react-native-async-storage/async-storage";
import { useFocusEffect } from "@react-navigation/native";
import { useLocalSearchParams, useRouter } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import { ActivityIndicator, FlatList, Pressable, StyleSheet, Text, View } from 'react-native';
import { API } from "../../config/api"; // ✅ ADDED





const COURSE_KEYS: Record<string,string> = {
  DSA: "dsa_full_course",
  ReinforcementLearning: "rl_full_course",
  JAVA: "java_full_course",
  "big-data": "big-data",
};

type Topic = {
  id: number;
  topic_key: string;
  is_free: boolean;
};



export default function CourseListScreen(){

  const [hasAccess,setHasAccess] = useState(false);
  const [loading,setLoading] = useState(true);

  const router = useRouter();
  const { course } = useLocalSearchParams<{ course?: string }>();

const safeCourse = course ?? "dsa";
console.log("PARAM COURSE =", course);
console.log("SAFE COURSE =", safeCourse);
console.log(
  "FETCH URL:",
  `${API}/topics/${safeCourse}`
);
  useEffect(() => {

  const loadTopics = async () => {

    try {

    const res = await fetch(
  `${API}/topics/${safeCourse}`
);

      const data = await res.json();

      console.log("TOPICS:", data);

      setTopics(data);

    } catch (e) {

      console.log(e);

    }

  };

  loadTopics();

}, [safeCourse]);
  const [topics, setTopics] = useState<Topic[]>([]);
  useFocusEffect(
    useCallback(()=>{

      const checkUnlock = async ()=>{

        try{
          setLoading(true);

          const userId = await AsyncStorage.getItem("user_id");

          if(!userId){
            setHasAccess(false);
            setLoading(false);
            return;
          }

 const topicsRes = await fetch(
  `${API}/topics/${safeCourse}`
);

const topicsData = await topicsRes.json();

const paidTopic = topicsData.find(
  (t: any) => !t.is_free
);

if (!paidTopic) {
  setHasAccess(false);
  setLoading(false);
  return;
}

const topicId = paidTopic.id;

console.log("SAFE COURSE:", safeCourse);
console.log("CHECK TOPIC ID:", topicId);
console.log("USER ID:", userId);

const res = await fetch(
  `${API}/purchase/check/${topicId}/${userId}`
);
if(!res.ok){
  console.log("API ERROR:", res.status);
  setHasAccess(false);
  return;
}

const d = await res.json();

          setHasAccess(d.unlocked);
          if(typeof d.unlocked !== "boolean"){
  console.log("Invalid API response", d);
}

        }catch(e){
          console.log("unlock error",e);
          setHasAccess(false);
        }

        setLoading(false);
      };

      checkUnlock();

    },[safeCourse])
  );

const isTopicLocked = (topic: Topic) => {

  // Free topic
  if (topic.is_free) {
    return false;
  }

  // Paid topic
  return !hasAccess;
};

  if(loading){
    return(
      <View style={[styles.container,{justifyContent:"center"}]}>
        <ActivityIndicator size="large" color="#123C7B"/>
      </View>
    );
  }

  const renderItem = ({ item }: { item: Topic }) => {

    const locked = isTopicLocked(item);

    return (
      <Pressable
        style={[styles.card, locked && styles.lockedCard]}
        onPress={() => {

          if(locked){
            router.push({
              pathname:"/purchase",
  params:{ course: COURSE_KEYS[safeCourse] || safeCourse }
            });
            return;
          }

          router.push({
            pathname:"/quiz",
            params:{
              topicKey: item.topic_key,
title: item.topic_key
            }
          });

        }}
      >
        <Ionicons
          name={locked ? 'lock-closed' : 'help-circle-outline'}
          size={22}
          color={locked ? '#999' : '#123C7B'}
        />

        <Text style={[styles.cardText, locked && {color:"#999"}]}>
          {item.topic_key}
        </Text>

        <Ionicons name="chevron-forward" size={18} color="#999" />
      </Pressable>
    );
  };

  return(
    <View style={styles.container}>
      <Text style={styles.heading}>📘 {safeCourse} Topics</Text>

      <FlatList
  data={topics}
  keyExtractor={(item, index) =>
    String(item.id ?? index)
  }
  renderItem={renderItem}
/>
    </View>
  );
}

const styles = StyleSheet.create({

container:{ 
  flex:1, 
  padding:5, 
  backgroundColor:"#F3F4F6", 
  paddingBottom:0,
  paddingRight:6,
  paddingLeft:10
},

heading:{ 
  fontSize:20, 
  fontWeight:"800", 
  marginBottom:10, 
  marginTop:40, 
  color:"#1E3A8A",
  letterSpacing:0.5
},

card:{ 
  flexDirection:"row", 
  alignItems:"center", 
  backgroundColor:"#ffffff", 
  paddingVertical:18, 
  paddingHorizontal:18, 
  borderRadius:20, 
  marginBottom:16,
  paddingRight:10,
  paddingLeft:10,
  // 🔥 LEFT BLUE STRIP (main design)
  borderLeftWidth:6,
  borderLeftColor:"#1E3A8A",

  // 🔥 SHADOW (premium feel)
  shadowColor:"#000",
  shadowOpacity:0.08,
  shadowRadius:10,
  elevation:5
},

lockedCard:{ 
  backgroundColor:"#F1F1F1",
  borderLeftColor:"#999",
  opacity:0.85
},

cardText:{ 
  flex:1, 
  marginLeft:14, 
  fontSize:16, 
  fontWeight:"600",
  color:"#111"
},

iconBox:{
  width:38,
  height:38,
  borderRadius:12,
  backgroundColor:"#EEF2FF",
  alignItems:"center",
  justifyContent:"center"
},

lockedIcon:{
  backgroundColor:"#E5E5E5"
},

chevron:{
  marginLeft:10
}

});