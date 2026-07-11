import { useLocalSearchParams, useRouter } from "expo-router";
import { useState } from "react";
import {
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
} from "react-native";
import { API } from "../../config/api";

export default function ResetPassword() {

  const router = useRouter();
  const { email } = useLocalSearchParams();

  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [loading, setLoading] = useState(false);

  async function resetPassword() {

    if (!password || !confirmPassword) {
      alert("Please fill all fields");
      return;
    }

    if (password !== confirmPassword) {
      alert("Passwords do not match");
      return;
    }

    if (password.length < 6) {
      alert("Password must be at least 6 characters");
      return;
    }

    try {

      setLoading(true);

      const res = await fetch(`${API}/auth/reset-password`, {

        method: "POST",

        headers: {
          "Content-Type": "application/json",
        },

        body: JSON.stringify({
          email,
          password,
        }),

      });

      const data = await res.json();

      if (!data.success) {
        alert(data.message);
        return;
      }

      alert("Password Updated Successfully");

      router.replace("/auth/login");

    } catch (e) {

      console.log(e);

      alert("Server Error");

    } finally {

      setLoading(false);

    }

  }

  return (

    <View style={styles.container}>

      <Text style={styles.title}>Reset Password</Text>

      <Text style={styles.label}>New Password</Text>

<TextInput
  placeholder="New Password"
  placeholderTextColor="#888"
  secureTextEntry
  value={password}
  onChangeText={setPassword}
  style={styles.input}
/>

<Text style={styles.label}>Confirm Password</Text>

<TextInput
  placeholder="Confirm Password"
  placeholderTextColor="#888"
  secureTextEntry
  value={confirmPassword}
  onChangeText={setConfirmPassword}
  style={styles.input}
/>

      <Pressable
        style={styles.button}
        onPress={resetPassword}
      >

        <Text style={styles.buttonText}>
          {loading ? "Updating..." : "Reset Password"}
        </Text>

      </Pressable>

    </View>

  );

}

const styles = StyleSheet.create({

container: {
  flex: 1,
  justifyContent: "center",
  padding: 25,
  backgroundColor: "#F5F7FB",
},

title: {
  fontSize: 28,
  fontWeight: "700",
  marginBottom: 25,
  textAlign: "center",
  color: "#123C7B",
},

input: {
  borderWidth: 1,
  borderColor: "#ddd",
  padding: 15,
  borderRadius: 10,
  marginBottom: 15,
  backgroundColor: "#fff",
  color: "#000",
  fontSize: 15,
},

label: {
  fontSize: 16,
  fontWeight: "600",
  color: "#333",
  marginBottom: 6,
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