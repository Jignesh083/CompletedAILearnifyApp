import AsyncStorage from "@react-native-async-storage/async-storage";
import { useLocalSearchParams, useRouter } from "expo-router";
import { Pressable, StyleSheet, Text, View } from "react-native";
import RazorpayCheckout from "react-native-razorpay";

// 🔥 CHANGE AFTER DEPLOY
const API = "https://ailearnifyapp-tbrt.onrender.com";

export default function Purchase(){

 const router = useRouter();
 const { course } = useLocalSearchParams();



 // 🔥 NEW: VERIFY RETRY FUNCTION
 async function verifyWithRetry(body:any, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      console.log(`VERIFY ATTEMPT ${i + 1}`);

      const res = await fetch(`${API}/payment/verify`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      if (res.ok) return res;

    } catch (e) {
      console.log("VERIFY ERROR RETRY:", e);
    }

    // wait 2 sec before retry
    await new Promise(r => setTimeout(r, 2000));
  }

  throw new Error("Verify failed after retries");
 }

 async function startPayment(){

  try{

    const userId = await AsyncStorage.getItem("user_id");

if (!userId) {
  alert("Please login first");
  return;
}

    if(!course){
      alert("Course missing");
      return;
    }

    const courseKey = course as string;


const topicsRes = await fetch(
  `${API}/topics/${courseKey}`
);

const topicsData = await topicsRes.json();

if (!topicsData.length) {
  alert("No topics found");
  return;
}

// First paid topic
const paidTopic = topicsData.find(t => !t.is_free);

if (!paidTopic) {
  alert("No paid topic found");
  return;
}

const topicId = paidTopic.id;

console.log("PAID TOPIC:", paidTopic);
console.log("TOPIC ID:", topicId);


// if(!subjectData.success){
//   console.log("Subject not found");
//   return;
// }



// console.log("SUBJECT:", subjectData.subject);
console.log("SUBJECT ID:", topicId);

    console.log("COURSE PARAM:", course);
console.log("TOPIC ID:", topicId);
    if(!topicId){
      alert("Invalid course mapping");
      return;
    }

    console.log("PAYMENT USER:", userId);
    console.log("COURSE:", courseKey);
    console.log("TOPIC ID:", topicId);

    // ✅ CHECK PURCHASE
    const check = await fetch(
      `${API}/purchase/check/${topicId}/${userId}`
    );

    const checkData = await check.json();

    console.log("CHECK RESPONSE:", checkData);

    if(checkData.unlocked){
      alert("Already purchased");
      router.replace("/course-detail");
      return;
    }

    // 🔥 wake server
    await fetch(`${API}/check-db`);

    // ⭐ CREATE ORDER
    const res = await fetch(
      `${API}/payment/create-order`,
      { method:"POST" }
    );

    const data = await res.json();

    const options = {
      description:"Course Purchase",
      currency:"INR",
      key:"rzp_live_SSgm493FHbxcNw",
      amount:data.amount,
      name:"AILearnify",
      order_id:data.id,
      theme:{color:"#123C7B"}
    };

    RazorpayCheckout.open(options)
    .then(async(result)=>{

      console.log("PAYMENT SUCCESS:", result);
  await new Promise(res => setTimeout(res, 2000));
      try {

        console.log("VERIFY CALL START");

        const body = {
          user_id:userId,
          topic_id: topicId,
          razorpay_payment_id: result.razorpay_payment_id
        };

        console.log("VERIFY BODY:", body);

        // 🔥 FIX: USE RETRY
        const verifyRes = await verifyWithRetry(body);

        console.log("VERIFY STATUS:", verifyRes.status);

        const text = await verifyRes.text();
        console.log("VERIFY RAW:", text);

        let verifyData;

        try {
          verifyData = JSON.parse(text);
        } catch {
          alert("Server error (invalid response)");
          return;
        }

        if (!verifyRes.ok || !verifyData?.success) {
          console.log("VERIFY FAILED:", verifyData);
          alert("Server error");
          return;
        }

        console.log("✅ PURCHASE INSERTED SUCCESSFULLY");

        alert("Payment Successful ✅");
console.log("AFTER PAYMENT COURSE KEY =", courseKey);
console.log("REDIRECT COURSE =", courseKey);
       router.replace({
  pathname: "/(tabs)/courselist",
  params: { course: courseKey }
});

      } catch (err) {

        console.log("VERIFY NETWORK ERROR:", err);

        alert("Payment done but verification failed (retry later)");

       router.replace({
  pathname: "/(tabs)/courselist",
  params: { course: courseKey }
});

      }

    })
    .catch((err)=>{
      console.log("PAYMENT ERROR:", err);
      alert("Payment Cancelled");
    });

  }catch(e){
    console.log("GENERAL ERROR:", e);
    alert("Payment error");
  }

 }

 return(
  <View style={styles.container}>
   <Text style={styles.title}>Unlock Course</Text>

   <Pressable style={styles.btn} onPress={startPayment}>
    <Text style={styles.btnText}>Pay ₹499</Text>
   </Pressable>
  </View>
 );

}

const styles = StyleSheet.create({
 container:{ flex:1, justifyContent:"center", alignItems:"center" },
 title:{ fontSize:24, fontWeight:"bold", marginBottom:20 },
 btn:{ backgroundColor:"#123C7B", padding:15, borderRadius:10 },
 btnText:{ color:"#fff", fontWeight:"600" }
});