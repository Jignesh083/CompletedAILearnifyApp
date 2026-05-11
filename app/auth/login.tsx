import AsyncStorage from "@react-native-async-storage/async-storage";
import { useRouter } from "expo-router";
import { useEffect, useRef, useState } from "react";
import { Animated, Pressable, StyleSheet, Text, TextInput } from "react-native";
import { supabase } from "../../supabase";

export default function Login(){

 const router = useRouter();

 const [email,setEmail] = useState("");
 const [password,setPassword] = useState("");
 const [loading,setLoading] = useState(false);

 // ✅ EMAIL ERROR STATE
 const [emailError,setEmailError] = useState("");

 // animation (same as before)
 const fadeAnim = useRef(new Animated.Value(0)).current;
 const slideAnim = useRef(new Animated.Value(40)).current;

 useEffect(()=>{
  Animated.parallel([
    Animated.timing(fadeAnim,{
      toValue:1,
      duration:500,
      useNativeDriver:true
    }),
    Animated.timing(slideAnim,{
      toValue:0,
      duration:500,
      useNativeDriver:true
    })
  ]).start();
 },[]);

async function login() {

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // RESET
  setEmailError("");

  if (!email || !password) {
    setEmailError("Email is required");
    alert("Please enter email and password");
    return;
  }

  if (!emailRegex.test(email)) {
    setEmailError("Enter valid email");
    alert("Please enter a valid email address");
    return;
  }

  if (password.length < 4) {
    alert("Password must be at least 4 characters");
    return;
  }

  try {

    setLoading(true);

    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .eq('password', password)
      .single();

    if (error || !data) {
      alert("Invalid credentials");
      return;
    }

    await AsyncStorage.setItem("token", "logged_in");
    await AsyncStorage.setItem("user_id", data.id.toString());
    await AsyncStorage.setItem("user_email", email);

    try {
      const { data: purchases } = await supabase
        .from('purchases')
        .select('*')
        .eq('user_id', data.id);

      await AsyncStorage.setItem(
        "purchased_courses",
        JSON.stringify(purchases || [])
      );

    } catch (e) {
      console.log("Purchase sync error", e);
    }

    router.replace("/(tabs)");

  } catch (err) {

    console.log("Login error:", err);
    alert("Something went wrong");

  } finally {

    setLoading(false);

  }
}

 return(

  <Animated.View 
    style={[
      styles.container,
      {
        opacity: fadeAnim,
        transform:[{ translateY: slideAnim }]
      }
    ]}
  >

   <Text style={styles.title}>Login</Text>

   {/* EMAIL */}
   <TextInput
    placeholder="Email"
    style={styles.input}
    onChangeText={(text)=>{
      setEmail(text);
      setEmailError(""); // clear on typing
    }}
   />

   {/* 🔴 ERROR TEXT */}
   {emailError ? (
     <Text style={styles.errorText}>{emailError}</Text>
   ) : null}

   <TextInput
    placeholder="Password"
    style={styles.input}
    secureTextEntry
    onChangeText={setPassword}
   />

   <Pressable style={styles.btn} onPress={login}>
    <Text style={styles.btnText}>
     {loading ? "Please wait..." : "Login"}
    </Text>
   </Pressable>

   <Pressable onPress={()=>router.push("/auth/register")}>
    <Text style={styles.link}>Create Account</Text>
   </Pressable>

  </Animated.View>

 );

}

const styles = StyleSheet.create({

container:{
 flex:1,
 justifyContent:"center",
 padding:24,
 backgroundColor:"#F5F7FB"
},

title:{
 fontSize:28,
 fontWeight:"700",
 marginBottom:6,
 color:"#111",
 letterSpacing:0.5
},

input:{
 borderWidth:1,
 borderColor:"#E5E7EB",
 padding:14,
 marginBottom:10,
 borderRadius:12,
 backgroundColor:"#fff",
 fontSize:15,
 shadowColor:"#000",
 shadowOpacity:0.03,
 shadowRadius:4,
 elevation:2
},

// ✅ NEW STYLE (only addition)
errorText:{
 color:"#e53935",
 fontSize:12,
 marginBottom:10,
 marginLeft:2
},

btn:{
 backgroundColor:"#123C7B",
 padding:16,
 borderRadius:12,
 alignItems:"center",
 marginTop:8,
 shadowColor:"#123C7B",
 shadowOpacity:0.2,
 shadowRadius:6,
 elevation:3
},

btnText:{
 color:"#fff",
 fontWeight:"600",
 fontSize:16,
 letterSpacing:0.5
},

link:{
 marginTop:20,
 textAlign:"center",
 color:"#123C7B",
 fontWeight:"500",
 fontSize:14
}

}); 