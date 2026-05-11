import { Ionicons } from '@expo/vector-icons';
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useFocusEffect } from "@react-navigation/native";
import { useLocalSearchParams, useRouter } from 'expo-router';
import { useCallback, useState } from 'react';
import { ActivityIndicator, FlatList, Pressable, StyleSheet, Text, View } from 'react-native';
import { API } from "../../config/api"; // ✅ ADDED



const COURSE_KEYS: Record<string,string> = {
  ReinforcementLearning: "rl_full_course",
  DSA: "dsa_full_course",
  JAVA: "java_full_course"
};

type Topic = {
  id: string;
  title: string;
  type: 'quiz';
  isFree?: boolean;
};

const COURSE_TOPICS: Record<string, Topic[]> = {

  DSA: [
    { id: 'dsa_intro', title: 'DSA Introduction', type: 'quiz' },
    { id: 'time_space', title: 'Time & Space Complexity', type: 'quiz' },
    { id: 'arrays', title: 'Arrays Basics', type: 'quiz' },
    { id: 'strings', title: 'Strings Basics', type: 'quiz' },
    { id: 'searching', title: 'Searching Algorithms', type: 'quiz' },
    { id: 'sorting', title: 'Sorting Algorithms', type: 'quiz' },
    { id: 'maths', title: 'Basic Mathematics', type: 'quiz' },
    { id: 'stack', title: 'Stack (Introduction)', type: 'quiz' },
    { id: 'queue', title: 'Queue (Introduction)', type: 'quiz' },
    { id: 'practice', title: 'Practice Problems (Easy)', type: 'quiz' },
  ],

 Reinforcement_Learning: [
  { id: 'rl_intro', title: 'RL Introduction & Basics', type: 'quiz'},
  { id: 'rl_agent_environment', title: 'RL Agent & Environment', type: 'quiz'},
  // { id: 'rl_states_actions_rewards', title: 'RL States, Actions & Rewards', type: 'quiz'},
  // { id: 'rl_policy', title: 'RL Policy', type: 'quiz' },
  // { id:'rl_episode',title:'Episodes & Returns', type:'quiz'},
  // { id: 'rl_discount_factor', title: 'Discount Factor', type: 'quiz' },
  // { id:'rl_exploration_vs_exploitation' ,title:'Exploration vs Exploitation', type:'quiz'},
  { id: 'rl_framework', title: 'RL Framework', type: 'quiz', isFree: true },
  // { id:'rl_value_function' ,title:'Value Function', type:'quiz', isFree: true},
  { id:'rl_action_value_function' ,title:'Action-Value Function', type:'quiz', isFree: true},
  // { id: 'rl_mdp_intro', title: 'Markov Decision Process (MDP) Introduction', type: 'quiz', isFree: true },
  // { id: 'rl_markov_property', title: 'Markov Property', type: 'quiz', isFree: true },
// { id: 'rl_state_action_space', title: 'State & Action Space', type: 'quiz', isFree: true },
// { id: 'rl_transition_function', title: 'Transition Function', type: 'quiz', isFree: true },
// { id: 'rl_reward_function', title: 'Reward Function', type: 'quiz', isFree: true },
// { id: 'rl_policy_mdp', title: 'Policy in MDP', type: 'quiz', isFree: true },
// { id: 'rl_value_function_mdp', title: 'Value Function in MDP', type: 'quiz', isFree: true },
{ id: 'rl_dynamic_programming', title: 'Dynamic Programming', type: 'quiz', isFree: true },
// { id: 'rl_policy_evaluation', title: 'Policy Evaluation', type: 'quiz', isFree: true },
// { id: 'rl_policy_improvement', title: 'Policy Improvement', type: 'quiz', isFree: true },
{ id: 'rl_policy_iteration', title: 'Policy Iteration', type: 'quiz', isFree: true },
{ id: 'rl_value_iteration', title: 'Value Iteration', type: 'quiz', isFree: true },
{ id: 'rl_principle_of_optimality', title: 'Principle of Optimality', type: 'quiz', isFree: true },
// { id: 'rl_bellman_equation', title: 'Bellman Equation', type: 'quiz', isFree: true },
],

  JAVA: [
    { id: 'java_intro', title: 'Java Introduction', type: 'quiz' },
  ],
};

export default function CourseListScreen(){

  const [hasAccess,setHasAccess] = useState(false);
  const [loading,setLoading] = useState(true);

  const router = useRouter();
  const { course } = useLocalSearchParams<{ course?: string }>();

  const safeCourse = course ?? "DSA";
  const topics: Topic[] = COURSE_TOPICS[safeCourse] ?? [];

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

          const key = COURSE_KEYS[safeCourse];

          if(!key || safeCourse === "DSA"){
            setHasAccess(true);
            setLoading(false);
            return;
          }

         const res = await fetch(
  `${API}/purchase/check/${key}/${userId}`
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

    if(safeCourse === "DSA") return false;
    if(topic.isFree) return false;

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
              params:{ course: COURSE_KEYS[safeCourse] } // ✅ FIXED ONLY THIS
            });
            return;
          }

          router.push({
            pathname:"/quiz",
            params:{
              topicKey: item.id,
              title:item.title
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
          {item.title}
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
        keyExtractor={(item)=>item.id}
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