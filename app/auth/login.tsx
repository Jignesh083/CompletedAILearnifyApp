import { Ionicons } from "@expo/vector-icons";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useRouter } from "expo-router";
import { useEffect, useRef, useState } from "react";
import {
  Animated,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View
} from "react-native";
import { API } from "../../config/api";
// import { supabase } from "../../supabase";
export default function Login(){

 const router = useRouter();

 const [email,setEmail] = useState("");
 const [password,setPassword] = useState("");
 const [showPassword, setShowPassword] = useState(false);
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

  setEmailError("");

  if (!email || !password) {
    setEmailError("Email is required");
    alert("Please enter email and password");
    return;
  }

  if (!emailRegex.test(email)) {
    setEmailError("Enter valid email");
    alert("Please enter a valid email");
    return;
  }

  try {

    setLoading(true);

    const response = await fetch(`${API}/auth/login`, {

      method: "POST",

      headers: {
        "Content-Type": "application/json",
      },

      body: JSON.stringify({
        email,
        password,
      }),

    });

    const data = await response.json();

    if (!data.success) {
      alert(data.error || "Login Failed");
      return;
    }

    
await AsyncStorage.setItem("token", "logged_in");
await AsyncStorage.setItem("user_id", String(data.user_id));
await AsyncStorage.setItem("user_email", email);

// Login successful → Start background music
// await playBackgroundMusic();

router.replace("/(tabs)");

  } catch (e) {

    console.log(e);
    alert("Server Error");

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
<Text style={styles.label}>Email</Text>
   {/* EMAIL */}
   <TextInput
  placeholder="Email"
  placeholderTextColor="#888"
  style={styles.input}
  value={email}
  onChangeText={(text) => {
    setEmail(text);
    setEmailError("");
  }}
/>

   {/* 🔴 ERROR TEXT */}
   {emailError ? (
     <Text style={styles.errorText}>{emailError}</Text>
   ) : null}


  <Text style={styles.label}>Password</Text>
<View style={styles.passwordContainer}>
  <TextInput
  placeholder="Password"
  placeholderTextColor="#888"
  style={styles.passwordInput}
  secureTextEntry={!showPassword}
  value={password}
  onChangeText={setPassword}
/>

  <Pressable onPress={() => setShowPassword(!showPassword)}>
    <Ionicons
      name={showPassword ? "eye-off" : "eye"}
      size={22}
      color="#777"
    />
  </Pressable>
</View>

   <Pressable style={styles.btn} onPress={login}>
    <Text style={styles.btnText}>
     {loading ? "Please wait..." : "Login"}
    </Text>
   </Pressable>

<View style={styles.footerLinks}>

  <Pressable onPress={() => router.push("/auth/forgot-password")}>
    <Text style={styles.footerLink}>
      Forgot Password?
    </Text>
  </Pressable>

  <Text style={styles.separator}>|</Text>

  <Pressable onPress={() => router.push("/auth/register")}>
    <Text style={styles.footerLink}>
      Create Account
    </Text>
  </Pressable>

</View>

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
  fontWeight:"bold",
  marginBottom:25,
  textAlign:"center",
  color:"#123C7B"
},

input: {
  borderWidth: 1,
  borderColor: "#E5E7EB",
  padding: 14,
  marginBottom: 10,
  borderRadius: 12,
  backgroundColor: "#fff",
  fontSize: 15,
  color: "#000",   // 👈 ye add karo
  shadowColor: "#000",
  shadowOpacity: 0.03,
  shadowRadius: 4,
  elevation: 2
},
label: {
  fontSize: 16,
  fontWeight: "600",
  color: "#333",
  marginBottom: 6,
  marginTop: -5,
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
},
passwordContainer: {
  flexDirection: "row",
  alignItems: "center",
  borderWidth: 1,
  borderColor: "#E5E7EB",
  borderRadius: 12,
  backgroundColor: "#fff",
  paddingHorizontal: 15,
  marginBottom: 10,
  shadowColor: "#000",
  shadowOpacity: 0.03,
  shadowRadius: 4,
  elevation: 2,
},

passwordInput: {
  flex: 1,
  height: 56,
  fontSize: 16,
  color: "#000", // 👈 ye add karo
},
footerLinks: {
  flexDirection: "row",
  justifyContent: "center",
  alignItems: "center",
  marginTop: 15,
},

footerLink: {
  color: "#123C7B",
  fontSize: 15,
  fontWeight: "600",
  paddingHorizontal: 8,
},

separator: {
  color: "#999",
  fontSize: 16,
  fontWeight: "600",
},
}); 


