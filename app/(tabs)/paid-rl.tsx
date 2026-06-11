import AsyncStorage from "@react-native-async-storage/async-storage";
import { useFocusEffect } from "@react-navigation/native";
import { useRouter } from "expo-router";
import { useCallback, useState } from "react";
import { ActivityIndicator, FlatList, Pressable, StyleSheet, Text, View } from "react-native";
import RazorpayCheckout from 'react-native-razorpay';
import { API } from "../../config/api";

// ⭐ FULL COURSE ID (IMPORTANT)
const COURSE_TOPIC_ID = 175;

const RL_TOPICS = [
  { id:"rl_td0", title:"TD(0)" },
  { id:"rl_td1", title:"TD(1)" },
  { id:"rl_tdlambda", title:"TD(λ)" },
  { id:"rl_k_step", title:"k-Step Estimators" },
  { id:"rl_on_off_policy", title:"On-Policy vs Off-Policy Learning" },
  { id:"rl_sarsa", title:"SARSA" },
  { id:"rl_q_learning", title:"Q-Learning" },
  { id:"rl_function_approximation", title:"Function Approximation" },
  { id:"rl_gradient_descent_methods", title:"Gradient Descent Methods" },
  { id:"rl_gradient_monte_carlo", title:"Gradient Monte Carlo" },
  { id:"rl_semi_gradient_td", title:"Semi-Gradient TD" },
  { id:"rl_eligibility_traces", title:"Eligibility Traces" },
  { id:"rl_intro_deep_rl", title:"Introduction to Deep RL" },
  { id:"rl_multi_armed_bandits", title:"Multi Armed Bandits" },
  { id:"rl_policy_gradient", title:"Policy Gradient Methods" },
  { id:"rl_actor_critic", title:"Actor Critic Methods" },
  { id:"rl_dqn", title:"Deep Q Network" },
  { id:"rl_double_dqn", title:"Double DQN" },
  { id:"rl_applications", title:"RL Applications" },
  { id:"rl_multi_agent", title:"Multi Agent RL" },
];

export default function PaidRLTopics(){

  const [purchased,setPurchased] = useState(false);
  const [loading,setLoading] = useState(true);
  const [payLoading,setPayLoading] = useState(false);

  const router = useRouter();

  /* ⭐ REALTIME UNLOCK CHECK (FIXED) */
  useFocusEffect(
    useCallback(()=>{

      const loadUnlock = async ()=>{

        try{

          const userId = await AsyncStorage.getItem("user_id");

          if(!userId){
            setPurchased(false);
            setLoading(false);
            return;
          }

       const res = await fetch(
  `${API}/purchase/check/${COURSE_TOPIC_ID}/${userId}`
);

if(!res.ok){
  console.log("API ERROR:", res.status);
  setPurchased(false);
  return;
}

const d = await res.json();

          console.log("UNLOCK RESPONSE:", d);

          setPurchased(d.unlocked);

        }catch(e){
          console.log("UNLOCK ERROR:", e);
          setPurchased(false);
        }

        setLoading(false);
      };

      loadUnlock();

    },[])
  );

  if(loading){
    return(
      <View style={{flex:1,justifyContent:"center",alignItems:"center"}}>
        <ActivityIndicator size="large"/>
        <Text>Checking Course Access...</Text>
      </View>
    );
  }

  /* ⭐ PAYMENT */
  const buyCourse = async ()=>{

    try{

      setPayLoading(true);

      const orderRes = await fetch(`${API}/payment/create-order`,{
        method:"POST"
      });

      const order = await orderRes.json();

      const storedUser = await AsyncStorage.getItem("user_id");

      const raw = await AsyncStorage.getItem("user_profile");
      const profile = raw ? JSON.parse(raw) : null;

      const options = {
        description: 'Reinforcement Learning Full Course',
        currency: 'INR',
          key: 'rzp_live_SSgm493FHbxcNw', // 🔥 LIVE KEY FOR PRODUCTION
        amount: order.amount,
        order_id: order.id,
        name: 'AI Core Learning',

        prefill:{
          name: profile?.name || "",
          email: profile?.email || "",
          contact: profile?.phone || ""
        },

        theme:{ color:'#123C7B' }
      };

      RazorpayCheckout.open(options)
      .then(async (response)=>{

        console.log("PAYMENT SUCCESS:", response);

        // ✅ FIX: topic_id send karo
        const verifyRes = await fetch(`${API}/payment/verify`,{
          method:"POST",
          headers:{ "Content-Type":"application/json" },
          body: JSON.stringify({
          razorpay_payment_id: response.razorpay_payment_id,
          user_id: storedUser,
          topic_id: COURSE_TOPIC_ID,
             // 🔥 ADD THIS (FIX)
          email: profile?.email || ""
          })
        });

        const verifyData = await verifyRes.json();
        if(!verifyRes.ok){
  console.log("VERIFY API ERROR");
  alert("Server error");
  return;
}

        console.log("VERIFY RESPONSE:", verifyData);

        if(!verifyData.success){
          alert("Payment save failed ❌");
          return;
        }

        setPurchased(true);

        alert("Course Purchased Successfully ✅");

      })
      .catch(()=>{
        alert("Payment Cancelled");
      });

    }catch(e){
      console.log("PAYMENT ERROR:", e);
      alert("Payment Error");
    }

    setPayLoading(false);
  };

  return(
    <View style={styles.container}>

      {/* ⭐ BUY BOX */}
      {!purchased && (
        <View style={styles.buyBox}>
          <Text style={styles.courseTitle}>🔥 RL Full Course</Text>
          <Text style={styles.price}>₹499 • 3 Months Access</Text>
          <Pressable style={styles.buyBtn} onPress={buyCourse}>
            {
              payLoading
              ? <ActivityIndicator color="#fff"/>
              : <Text style={styles.buyText}>BUY NOW</Text>
            }
          </Pressable>
        </View>
      )}

       {/* 🔥 NEW HEADING */}
    <Text style={styles.heading}>
      📘 Reinforcement Learning Topics
    </Text>

      {/* ⭐ TOPICS */}
      <FlatList
        data={RL_TOPICS}
        keyExtractor={(i)=>i.id}
        renderItem={({item})=>(

          <Pressable
            style={[styles.card,!purchased && styles.locked]}
            onPress={()=>{

              if(!purchased){
                alert("Buy course first");
                return;
              }

              router.push({
                pathname:"/(tabs)/quiz",
                params:{
                  topicKey : item.id,
                  title: item.title,
                  mode: "paid",
                      refresh: Date.now()   // 🔥 CHANGE NAME

                }
              });

            }}
          >
            <Text style={[styles.text,!purchased && {color:"#999"}]}>
              {purchased ? item.title : "🔒 "+item.title}
            </Text>
          </Pressable>

        )}
      />

    </View>
  );
}

const styles = StyleSheet.create({

container:{ 
  flex:1,
  paddingTop:30,
  backgroundColor:"#F3F4F6",
  paddingRight:5,
  paddingLeft:5
},
heading:{
  fontSize:20,
  fontWeight:"800",
  color:"#1E3A8A",
  marginBottom:10,
  marginTop:10,
  paddingHorizontal:10,
  letterSpacing:0.5
},
/* 🔥 BUY BOX (premium card) */
buyBox:{ 
  backgroundColor:"#ffffff",
  padding:20,
  borderRadius:20,
  marginBottom:20,

  shadowColor:"#000",
  shadowOpacity:0.08,
  shadowRadius:10,
  elevation:5,

  borderLeftWidth:6,
  borderLeftColor:"#1E3A8A"
},

courseTitle:{ 
  fontSize:20,
  fontWeight:"800",
  color:"#1E3A8A"
},

price:{ 
  marginTop:6,
  fontSize:14,
  color:"#666"
},

buyBtn:{ 
  marginTop:16,
  backgroundColor:"#1E3A8A",
  padding:16,
  borderRadius:12,
  alignItems:"center",

  shadowColor:"#1E3A8A",
  shadowOpacity:0.25,
  shadowRadius:6,
  elevation:3
},

buyText:{ 
  color:"#fff",
  fontWeight:"700",
  fontSize:16,
  letterSpacing:0.5
},

/* 🔥 TOPIC CARDS (same design as other screens) */
card:{
  paddingVertical:18,
  paddingHorizontal:18,
  backgroundColor:"#ffffff",
  borderRadius:20,
  marginBottom:14,

  flexDirection:"row",
  justifyContent:"space-between",
  alignItems:"center",

  // 🔥 LEFT STRIP (main UI)
  borderLeftWidth:6,
  borderLeftColor:"#1E3A8A",

  shadowColor:"#000",
  shadowOpacity:0.08,
  shadowRadius:10,
  elevation:5
},

locked:{ 
  backgroundColor:"#F1F1F1",
  borderLeftColor:"#9CA3AF",
  opacity:0.85
},

text:{ 
  fontSize:16,
  fontWeight:"600",
  color:"#111"
},

lockText:{
  color:"#999"
},

badge:{
  fontSize:12,
  fontWeight:"600",
  color:"#16A34A",
  backgroundColor:"#DCFCE7",
  paddingHorizontal:10,
  paddingVertical:4,
  borderRadius:8
}

});