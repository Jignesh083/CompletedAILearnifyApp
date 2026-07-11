import { useRouter } from "expo-router";
import { useState } from "react";
import { Pressable, StyleSheet, Text, TextInput, View } from "react-native";
import { API } from "../../config/api";
export default function ForgotPassword() {

  const router = useRouter();

  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);


  const sendOTP = async () => {

  if (!email) {
    alert("Please enter email");
    return;
  }

  try {

    setLoading(true);

    const response = await fetch(`${API}/auth/forgot-password`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email,
      }),
    });

    const data = await response.json();

    if (!data.success) {
      alert(data.message);
      return;
    }

    alert("OTP Sent");

    router.push({
      pathname: "/auth/verify-otp",
      params: {
        email,
      },
    });

  } catch (e) {

    console.log(e);
    alert("Server Error");

  } finally {

    setLoading(false);

  }

};

  return (
    <View style={styles.container}>

      <Text style={styles.title}>Forgot Password</Text>

      <Text style={styles.label}>Email</Text>

<TextInput
  placeholder="Enter Email"
  placeholderTextColor="#888"
  style={styles.input}
  value={email}
  onChangeText={setEmail}
/>

      <Pressable
  style={styles.btn}
  onPress={sendOTP}
>
  <Text style={styles.btnText}>
    {loading ? "Sending..." : "Send OTP"}
  </Text>
</Pressable>

      <Pressable onPress={() => router.back()}>
        <Text style={styles.link}>Back to Login</Text>
      </Pressable>

    </View>
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
marginBottom:20
},
label: {
  fontSize: 16,
  fontWeight: "600",
  color: "#333",
  marginBottom: 6,
},
input:{
borderWidth:1,
borderColor:"#ddd",
padding:15,
borderRadius:10,
marginBottom:20,
backgroundColor:"#fff",
  color: "#000",
    fontSize: 15,

},

btn:{
backgroundColor:"#123C7B",
padding:16,
borderRadius:10,
alignItems:"center"
},

btnText:{
color:"#fff",
fontWeight:"bold"
},

link:{
marginTop:20,
textAlign:"center",
color:"#123C7B"
}

});