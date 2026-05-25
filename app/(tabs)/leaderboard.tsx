import { useEffect, useState } from "react";
import { ActivityIndicator, FlatList, StyleSheet, Text, View } from "react-native";

// 🔥 CHANGE AFTER DEPLOY
const API = "https://ailearnifyapp-tbrt.onrender.com";
// ✅ TYPE DEFINE
type LeaderboardItem = {
  user_id: number;
  best_score: number;
};

export default function Leaderboard() {

 const [data, setData] = useState<LeaderboardItem[]>([]);
 const [loading, setLoading] = useState(true);

 useEffect(() => {
  fetchLeaderboard();
 }, []);

 async function fetchLeaderboard() {
  try {
    const res = await fetch(`${API}/leaderboard`);
    const json = await res.json();

    setData(json);
  } catch (err) {
    console.log("Leaderboard error:", err);
  } finally {
    setLoading(false);
  }
 }

 if (loading) {
  return (
    <View style={styles.loader}>
      <ActivityIndicator size="large" color="#123C7B" />
    </View>
  );
 }

 return(
  <View style={styles.container}>

   <Text style={styles.title}>🏆 Leaderboard</Text>

   <FlatList
    data={data}
    keyExtractor={(item, index) => index.toString()}
    renderItem={({ item, index }) => (
     <View style={styles.row}>

      <Text style={styles.rank}>#{index + 1}</Text>

      <Text style={styles.name}>
       User {item.user_id}
      </Text>

      <Text style={styles.score}>
       {item.best_score}
      </Text>

     </View>
    )}
   />

  </View>
 );

}

const styles = StyleSheet.create({

 container:{
  flex:1,
  padding:20,
  backgroundColor:"#fff"
 },

 title:{
  fontSize:22,
  fontWeight:"700",
  marginTop:40,
  marginBottom:20
 },

 row:{
  flexDirection:"row",
  justifyContent:"space-between",
  padding:15,
  backgroundColor:"#F4F8FF",
  borderRadius:10,
  marginBottom:10
 },

 rank:{
  fontWeight:"700"
 },

 name:{
  flex:1,
  marginLeft:10
 },

 score:{
  fontWeight:"700",
  color:"#123C7B"
 },

 loader:{
  flex:1,
  justifyContent:"center",
  alignItems:"center"
 }

});