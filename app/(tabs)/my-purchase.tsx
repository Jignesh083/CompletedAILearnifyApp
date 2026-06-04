import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from "expo-router";
import { useEffect, useState } from 'react';
import { FlatList, Pressable, StyleSheet, Text, View } from 'react-native';
import { API } from '../../config/api';
const courseNameMap: Record<string,string> = {
  "1":"DSA",
  "3":"Big Data",
  "81":"Reinforcement Learning",
  "200":"JAVA"
};
const routeMap: Record<string,string> = {
  "1": "dsa",
  "3": "big-data",
  "81": "reinforcement-learning",
  "200": "java"
};
export default function MyPurchase() {
const router = useRouter();

const [courses,setCourses]=useState<any[]>([])
  useEffect(()=>{

    async function load(){
const userId = await AsyncStorage.getItem("user_id");

const res = await fetch(
  `${API}/purchase/my/${userId}`
);

const data = await res.json();

if(data.success){
  setCourses(data.courses);
}
    }

    load()

  },[])

  return(

    <View style={styles.container}>

      <Text style={styles.heading}>My Purchased Courses</Text>

      {courses.length===0 && (
        <Text style={{color:"#999"}}>No course purchased yet</Text>
      )}

      <FlatList
        data={courses}
        keyExtractor={(item)=>
  String(item.topic_id)
}
     renderItem={({item})=>(
  <Pressable
    style={styles.card}
    onPress={()=>{
      router.push({
  pathname: "/(tabs)/courselist",
  params: {
course: item.subject_key  }
});
    }}
  >
<Text style={styles.course}>
  {item.subject_name}
</Text>
    <Text style={{color:"green"}}>Unlocked</Text>
  </Pressable>
)}
      />

    </View>

  )

}

const styles = StyleSheet.create({

container:{
  flex:1,
  padding:20,
  backgroundColor:"#F5F7FB"
},

heading:{
  marginTop:30,
  fontSize:24,
  fontWeight:'700',
  marginBottom:20,
  color:"#111",
  letterSpacing:0.5
},

card:{
  backgroundColor:"#fff",
  padding:16,
  borderRadius:14,
  marginBottom:14,

  // shadow
  shadowColor:"#000",
  shadowOpacity:0.05,
  shadowRadius:6,
  elevation:3,

  // layout
  flexDirection:"row",
  justifyContent:"space-between",
  alignItems:"center"
},

course:{
  fontWeight:"600",
  fontSize:16,
  color:"#222"
},

status:{
  color:"#16A34A",
  fontWeight:"600",
  fontSize:13,
  backgroundColor:"#DCFCE7",
  paddingHorizontal:10,
  paddingVertical:4,
  borderRadius:8
},

emptyText:{
  color:"#999",
  textAlign:"center",
  marginTop:30
}

});