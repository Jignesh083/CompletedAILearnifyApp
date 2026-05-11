import AsyncStorage from "@react-native-async-storage/async-storage";
import { useLocalSearchParams, useRouter } from 'expo-router';
import { useEffect, useState } from 'react';
import { ActivityIndicator, Pressable, StyleSheet, Text, View } from 'react-native';
import { API } from "../../config/api";
export default function PaidCourseDetailScreen() {

  const router = useRouter();
  const { title } = useLocalSearchParams<{ title?: string }>();

  const [loading, setLoading] = useState(true);
  const [unlocked, setUnlocked] = useState(false);

  // ⭐ SAME mapping use karo jo purchase me use kiya tha
  const COURSE_TOPIC_ID: Record<string, number> = {
    rl_full_course: 81,
    dsa_full_course: 1,
    java_full_course: 200
  };

  useEffect(() => {
    checkAccess();
  }, []);

  async function checkAccess() {
    try {
      const storedId = await AsyncStorage.getItem("user_id");

      if (!storedId) {
        setLoading(false);
        return;
      }

const userId = storedId;
      const topicId = COURSE_TOPIC_ID[title as string];

      if (!topicId) {
        setLoading(false);
        return;
      }

      const res = await fetch(
        `${API}/purchase/check/${topicId}/${userId}`
      );

      const data = await res.json();
      if(!res.ok){
  console.log("API ERROR:", res.status);
  setUnlocked(false);
  return;
}

      console.log("UNLOCK CHECK:", data);

      setUnlocked(data.unlocked);

    } catch (e) {
      console.log("UNLOCK ERROR:", e);
    } finally {
      setLoading(false);
    }
  }

  // ⏳ Loading
  if (loading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" />
      </View>
    );
  }

  // 🔓 UNLOCKED CONTENT
  if (unlocked) {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>🎉 Course Unlocked!</Text>

        <Text style={styles.desc}>
          Welcome to {title}

          {'\n\n'}

          ✅ Full syllabus access  
          ✅ Premium content  
          ✅ Mock interviews  
        </Text>
      </View>
    );
  }

  // 🔒 LOCKED CONTENT
  return (
    <View style={styles.container}>

      <Text style={styles.title}>
        {title ?? 'Premium Course'}
      </Text>

      <Text style={styles.desc}>
        🔒 This is a premium course.

        {'\n\n'}

        Access advanced concepts, interview problems,
        mock interviews and placement guidance.
      </Text>

      <Pressable
        style={styles.button}
        onPress={() =>
          router.push({
            pathname: '/purchase',
            params: { course: title } // ⭐ FIXED (title → course)
          })
        }
      >
        <Text style={styles.buttonText}>
          Unlock Full Course 🚀
        </Text>
      </Pressable>

    </View>
  );
}

const styles = StyleSheet.create({
container:{
flex:1,
backgroundColor:'#fff',
padding:20,
justifyContent:'center'
},
title:{
fontSize:20,
fontWeight:'800',
textAlign:'center',
marginBottom:14,
color:'#123C7B'
},
desc:{
fontSize:14,
color:'#555',
textAlign:'center',
marginBottom:30
},
button:{
backgroundColor:'#9B1C1C',
paddingVertical:14,
borderRadius:12
},
buttonText:{
color:'#fff',
fontWeight:'700',
textAlign:'center',
fontSize:15
}
});