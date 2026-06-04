import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from "expo-router";
import { useEffect, useState } from 'react';
import { FlatList, Pressable, StyleSheet, Text, View } from 'react-native';
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

  const [courses,setCourses]=useState<string[]>([])

  useEffect(()=>{

    async function load(){
const data=await AsyncStorage.getItem("purchased_courses")
      if(data){
        setCourses(JSON.parse(data))
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
        keyExtractor={(item)=>item}
     renderItem={({item})=>(
  <Pressable
    style={styles.card}
    onPress={()=>{
      router.push({
  pathname: "/topics/[course]",
  params: {
    course: routeMap[item]
  }
});
    }}
  >
<Text style={styles.course}>
  {courseNameMap[item] || item}
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