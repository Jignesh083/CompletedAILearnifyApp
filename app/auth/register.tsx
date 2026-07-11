import { useRouter } from "expo-router";
import { useEffect, useRef, useState } from "react";
import {
  Alert,
  Animated,
  Pressable,
  StyleSheet,
  Text,
  TextInput
} from "react-native";
import { supabase } from "../../supabase";

export default function Register() {

  const router = useRouter();

  const [name,setName] = useState("");
  const [email,setEmail] = useState("");
  const [password,setPassword] = useState("");
  const [loading,setLoading] = useState(false);

  // ✅ ANIMATION
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

async function register() {

  if (!name || !email || !password) {
    Alert.alert("Error", "Please fill all fields");
    return;
  }

  try {

    setLoading(true);

    const { data, error } = await supabase
      .from('users')
      .insert([
        {
          name: name,
          email: email,
          password: password
        }
      ]);

    if (error) {
      console.log("Supabase Error:", error);
      Alert.alert("Error", error.message);
      return;
    }

    Alert.alert("Success", "Account created successfully");

    router.replace("/auth/login");

  } catch (err) {

    console.log("Register error:", err);
    Alert.alert("Server Error", "Something went wrong");

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

      <Text style={styles.title}>Create Account</Text>
<Text style={styles.label}>Full Name</Text>
 <TextInput
  placeholder="Full Name"
  placeholderTextColor="#888"
  style={styles.input}
  value={name}
  onChangeText={setName}
/>
<Text style={styles.label}>Email</Text>

<TextInput
  placeholder="Email"
  placeholderTextColor="#888"
  style={styles.input}
  value={email}
  onChangeText={setEmail}
  autoCapitalize="none"
/>
<Text style={styles.label}>Password</Text>

<TextInput
  placeholder="Password"
  placeholderTextColor="#888"
  style={styles.input}
  secureTextEntry
  value={password}
  onChangeText={setPassword}
/>

      <Pressable
        style={styles.btn}
        onPress={register}
        disabled={loading}
      >
        <Text style={styles.btnText}>
          {loading ? "Creating..." : "Create Account"}
        </Text>
      </Pressable>

      <Pressable
        style={{marginTop:15}}
        onPress={()=>router.push("/auth/login")}
      >
        <Text style={styles.link}>
          Already have an account? Login
        </Text>
      </Pressable>

    </Animated.View>

  );

}

const styles = StyleSheet.create({

container:{
  flex:1,
  justifyContent:"center",
  padding:30,
  backgroundColor:"#ffffff"
},

title:{
  fontSize:28,
  fontWeight:"bold",
  marginBottom:25,
  textAlign:"center",
  color:"#123C7B"
},
label: {
  fontSize: 16,
  fontWeight: "600",
  color: "#333",
  marginBottom: 6,
},
input: {
  borderWidth: 1,
  borderColor: "#ddd",
  padding: 14,
  marginBottom: 12,
  borderRadius: 10,
  fontSize: 15,
  backgroundColor: "#fff",
  color: "#000", // 👈 Add this
},

btn:{
  backgroundColor:"#123C7B",
  padding:16,
  borderRadius:10,
  alignItems:"center",
  marginTop:5
},

btnText:{
  color:"#fff",
  fontWeight:"600",
  fontSize:16
},

link:{
  textAlign:"center",
  color:"#123C7B",
  fontWeight:"500"
}

});