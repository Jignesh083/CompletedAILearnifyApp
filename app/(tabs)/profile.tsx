import { Ionicons } from '@expo/vector-icons';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from 'expo-router';
import { useEffect, useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { API } from '../../config/api';


export default function Profile() {

  const router = useRouter();

  const [user,setUser] = useState({
    name: 'Student',
    completedQuizzes: 0,
    totalScore: 0,
    appVersion: '1.0.1',
  });

  const [loading,setLoading] = useState(false);

  // load user data
  useEffect(() => {
    loadUser();
  },[]);

const loadUser = async () => {
  try {
    const userId = await AsyncStorage.getItem("user_id");

    console.log("USER ID:", userId);

    if (!userId) return;

    const res = await fetch(`${API}/user/${userId}`);
    const data = await res.json();

    console.log("PROFILE DATA:", data);

    setUser(data);

  } catch (err) {
    console.log("User load error", err);
  }
};

const logout = async () => {

  try{

    setLoading(true);

    await AsyncStorage.multiRemove([
      'token',
      'user_id',
      'user_name',
      'purchased_courses'
    ]);

    router.replace('/auth/login');

  }catch(error){

    console.log("Logout error", error);

  }finally{

    setLoading(false);

  }

};

  return (
    <View style={styles.container}>

      {/* Avatar */}
      <View style={styles.avatar}>
        <Ionicons name="person" size={48} color="#fff" />
      </View>

      <Text style={styles.name}>{user.name}</Text>

      {/* Stats */}
      <View style={styles.statsBox}>

        <View style={styles.statItem}>
          <Text style={styles.statNumber}>{user.completedQuizzes}</Text>
          <Text style={styles.statLabel}>Quizzes</Text>
        </View>

        <View style={styles.statItem}>
          <Text style={styles.statNumber}>{user.totalScore}%</Text>
          <Text style={styles.statLabel}>Score</Text>
        </View>

      </View>

      {/* Settings */}
<Pressable
  style={styles.button}
  onPress={() => router.push("/settings")}
>

  <Ionicons name="settings-outline" size={18} color="#fff" />

  <Text style={styles.buttonText}>
    Settings
  </Text>

</Pressable>

      {/* Logout */}
      <Pressable style={[styles.button, styles.logout]} onPress={logout}>

        <Ionicons name="log-out-outline" size={18} color="#fff" />

        <Text style={styles.buttonText}>
          {loading ? "Logging out..." : "Logout"}
        </Text>

      </Pressable>

      {/* App Version */}
      <Text style={styles.version}>
        AI Learnify • Version {user.appVersion}
      </Text>


    </View>
  );
}

const styles = StyleSheet.create({

  container:{
    flex:1,
    backgroundColor:'#F5F7FB',
    alignItems:'center',
    paddingTop:60,
  },

  avatar:{
    width:95,
    height:95,
    borderRadius:50,
    backgroundColor:'#123C7B',
    alignItems:'center',
    justifyContent:'center',
    marginBottom:12,

    shadowColor:'#123C7B',
    shadowOpacity:0.3,
    shadowRadius:8,
    elevation:5,
  },

  name:{
    fontSize:22,
    fontWeight:'700',
    marginBottom:20,
    color:'#123C7B',
    letterSpacing:0.5,
  },

  statsBox:{
    flexDirection:'row',
    marginBottom:30,
    backgroundColor:'#fff',
    paddingVertical:18,
    paddingHorizontal:30,
    borderRadius:16,

    shadowColor:'#000',
    shadowOpacity:0.05,
    shadowRadius:6,
    elevation:3,
  },

  statItem:{
    marginHorizontal:25,
    alignItems:'center',
  },

  statNumber:{
    fontSize:20,
    fontWeight:'800',
    color:'#222',
  },

  statLabel:{
    fontSize:13,
    color:'#777',
    marginTop:4,
  },

  button:{
    flexDirection:'row',
    backgroundColor:'#123C7B',
    paddingVertical:14,
    paddingHorizontal:24,
    borderRadius:12,
    marginBottom:12,
    alignItems:'center',

    shadowColor:'#123C7B',
    shadowOpacity:0.25,
    shadowRadius:6,
    elevation:3,
  },

  logout:{
    backgroundColor:'#c0392b',
  },

  buttonText:{
    color:'#fff',
    fontWeight:'600',
    marginLeft:8,
    fontSize:15,
  },

  version:{
    marginTop:30,
    fontSize:12,
    color:'#888',
  }

});