import { useLocalSearchParams, useRouter } from "expo-router";
import { useEffect, useState } from "react";
import {
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
} from "react-native";
import { API } from "../../config/api";

export default function VerifyOTP() {

  const router = useRouter();

  const { email } = useLocalSearchParams();

  const [otp, setOtp] = useState("");
  const [loading, setLoading] = useState(false);
  const OTP_TIME = 300; // 5 minutes

const [timeLeft, setTimeLeft] = useState(OTP_TIME);

useEffect(() => {

  if (timeLeft <= 0) return;

  const timer = setInterval(() => {

    setTimeLeft((prev) => prev - 1);

  }, 1000);

  return () => clearInterval(timer);

}, [timeLeft]);
function formatTime(seconds) {

  const mins = Math.floor(seconds / 60);

  const secs = seconds % 60;

  return `${String(mins).padStart(2, "0")}:${String(secs).padStart(2, "0")}`;

}
  async function verifyOTP() {

    if (!otp) {
      alert("Enter OTP");
      return;
    }

    try {

      setLoading(true);

      const res = await fetch(`${API}/auth/verify-otp`, {

        method: "POST",

        headers: {
          "Content-Type": "application/json",
        },

        body: JSON.stringify({

          email,
          otp

        }),

      });

      const data = await res.json();

      if (!data.success) {

        alert(data.message);
        return;

      }

      alert("OTP Verified");

      router.replace({
        pathname: "/auth/reset-password",
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

  }

  return (

    <View style={styles.container}>

      <Text style={styles.title}>Verify OTP</Text>

      <TextInput
        placeholder="Enter OTP"
        keyboardType="number-pad"
        value={otp}
        onChangeText={setOtp}
        style={styles.input}
      />

    <Pressable
  style={[
    styles.button,
    timeLeft <= 0 && { backgroundColor: "#999" },
  ]}
  disabled={timeLeft <= 0}
  onPress={verifyOTP}
>
  <Text style={styles.buttonText}>
    {loading ? "Verifying..." : "Verify OTP"}
  </Text>
</Pressable>

<Text
  style={[
    styles.timer,
    timeLeft <= 0 && { color: "red" },
  ]}
>
  {timeLeft > 0
    ? `OTP expires in ${formatTime(timeLeft)}`
    : "OTP Expired"}
</Text>

    </View>

  );

}

const styles = StyleSheet.create({

container:{
flex:1,
justifyContent:"center",
padding:25
},

title:{
fontSize:30,
fontWeight:"700",
marginBottom:25
},
timer: {
  marginTop: 18,
  textAlign: "center",
  fontSize: 15,
  color: "#123C7B",
  fontWeight: "600",
},
input:{
borderWidth:1,
borderColor:"#ddd",
padding:15,
borderRadius:10,
marginBottom:20
},

button:{
backgroundColor:"#123C7B",
padding:16,
borderRadius:10,
alignItems:"center"
},

buttonText:{
color:"#fff",
fontWeight:"700"
}

});