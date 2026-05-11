import AsyncStorage from "@react-native-async-storage/async-storage";
import { useRouter } from "expo-router";
import { useEffect, useRef } from "react";
import { Animated, Image, Text, View } from "react-native";

export default function Splash() {

  const router = useRouter();

  const circleScale = useRef(new Animated.Value(0)).current;
  const logoOpacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {

    // logo fade animation
    Animated.timing(logoOpacity,{
      toValue:1,
      duration:600,
      useNativeDriver:true
    }).start();

    // circle animation
    setTimeout(()=>{
      Animated.timing(circleScale,{
        toValue:8,
        duration:900,
        useNativeDriver:true
      }).start();
    },600);

    // check login after splash animation
    const timer = setTimeout(checkAuth,1600);

    return () => clearTimeout(timer);

  },[]);


  const checkAuth = async () => {

    try {

      // PRO APP METHOD → token check
      const token = await AsyncStorage.getItem("token");

      if(token){
        router.replace("/(tabs)");
      }else{
        router.replace("/auth/login");
      }

    } catch (error) {

      router.replace("/auth/login");

    }

  };

  return (
    <View style={{
      flex:1,
      justifyContent:"center",
      alignItems:"center",
      backgroundColor:"#ffffff"
    }}>

      {/* expanding circle animation */}
      <Animated.View
        style={{
          position:"absolute",
          width:120,
          height:120,
          borderRadius:60,
          backgroundColor:"#123C7B",
          transform:[{scale:circleScale}]
        }}
      />

      {/* app logo */}
      <Animated.Image
        source={require("../assets/images/logo.png")}
        style={{
          width:180,
          height:180,
          opacity:logoOpacity
        }}
        resizeMode="contain"
      />

      {/* footer branding */}
      <View style={{
        position:"absolute",
        bottom:40,
        alignItems:"center"
      }}>

        <Text style={{
          fontSize:12,
          color:"#888",
          marginBottom:6
        }}>
          Created by
        </Text>

        <View style={{
          flexDirection:"row",
          alignItems:"center"
        }}>

          <Image
            source={require("../assets/images/logoCompany.png")}
            style={{
              width:22,
              height:22,
              marginRight:6
            }}
          />

          <Text style={{
            fontSize:14,
            fontWeight:"600",
            color:"#333"
          }}>
            AICORE SYSTEM
          </Text>

        </View>

      </View>

    </View>
  );
}