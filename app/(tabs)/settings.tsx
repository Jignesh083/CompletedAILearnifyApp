import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, Text, View } from 'react-native';

export default function Settings(){

  return(

    <View style={styles.container}>

      <Text style={styles.title}>Settings</Text>

      <Pressable style={styles.item}>
        <Ionicons name="person-outline" size={22} color="#123C7B"/>
        <Text style={styles.text}>Edit Profile</Text>
      </Pressable>

      <Pressable style={styles.item}>
        <Ionicons name="notifications-outline" size={22} color="#123C7B"/>
        <Text style={styles.text}>Notifications</Text>
      </Pressable>

      <Pressable style={styles.item}>
        <Ionicons name="lock-closed-outline" size={22} color="#123C7B"/>
        <Text style={styles.text}>Change Password</Text>
      </Pressable>

      <Pressable style={styles.item}>
        <Ionicons name="information-circle-outline" size={22} color="#123C7B"/>
        <Text style={styles.text}>About App</Text>
      </Pressable>

    </View>

  )

}

const styles = StyleSheet.create({

container:{
 flex:1,
 backgroundColor:"#fff",
 padding:25
},

title:{
 fontSize:26,
 fontWeight:"700",
 marginBottom:30,
 color:"#123C7B"
},

item:{
 flexDirection:"row",
 alignItems:"center",
 paddingVertical:16,
 borderBottomWidth:1,
 borderColor:"#eee"
},

text:{
 marginLeft:12,
 fontSize:16
}

})