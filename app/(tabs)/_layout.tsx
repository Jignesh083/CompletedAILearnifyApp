import { Ionicons } from '@expo/vector-icons';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Tabs } from 'expo-router';
import { useEffect, useRef } from 'react';
import { API } from "../../config/api"; // ✅ GLOBAL API

export default function TabLayout() {

const hasSynced = useRef(false);             // 🔥 add this

useEffect(() => {

  if (hasSynced.current) return;   // 🔥 already run → stop
  hasSynced.current = true;

  const syncPurchases = async () => {

    try {

      const userId = await AsyncStorage.getItem("user_id");
      if (!userId) return;

      console.log("SYNC PURCHASE FOR USER:", userId);

      const res = await fetch(`${API}/purchase/my/${userId}`);

      const text = await res.text();   // 🔥 handle HTML error safely

      let json;

      try {
        json = JSON.parse(text);
      } catch {
        console.log("❌ Server returned HTML", text);
        return;
      }

      console.log("RAW PURCHASE RESPONSE:", json);

      // ✅ IMPORTANT FIX: extract topic_id array
      const courses = (json.courses || []).map((c: { topic_id?: string | number }) => String(c.topic_id));

      // ✅ save clean array
      await AsyncStorage.setItem(
        "purchased_courses",
        JSON.stringify(courses)
      );

      console.log("✅ PURCHASE SYNC DONE:", courses);

    } catch (e) {
      console.log("❌ Purchase Sync Error", e);
    }

  };

  syncPurchases();

}, []);

  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: '#123C7B',
        tabBarInactiveTintColor: '#999',
        tabBarHideOnKeyboard: true,
      }}
    >
      <Tabs.Screen name="index" options={{
        title: 'Home',
        tabBarIcon: ({ color, size }) => (
          <Ionicons name="home" size={size} color={color} />
        ),
      }}/>

      <Tabs.Screen name="my-purchase" options={{
        title: 'My Purchase',
        tabBarIcon: ({ color, size }) => (
          <Ionicons name="cart" size={size} color={color} />
        ),
      }}/>

      <Tabs.Screen name="test-series" options={{
        title: 'Test Series',
        tabBarIcon: ({ color, size }) => (
          <Ionicons name="clipboard" size={size} color={color} />
        ),
      }}/>

      <Tabs.Screen name="profile" options={{
        title: 'Profile',
        tabBarIcon: ({ color, size }) => (
          <Ionicons name="person" size={size} color={color} />
        ),
      }}/>

      {/* 🔽 Hidden Screens */}
      <Tabs.Screen name="all-courses" options={{ href: null }} />
      <Tabs.Screen name="course-detail" options={{ href: null }} />
      <Tabs.Screen name="quiz" options={{ href: null }} />
      <Tabs.Screen name="daily-quiz" options={{ href: null }} />
      <Tabs.Screen name="paid-courses" options={{ href: null }} />
      <Tabs.Screen name="app-info" options={{ href: null }} />
      <Tabs.Screen name="syllabus" options={{ href: null }} />
      <Tabs.Screen name="courselist" options={{ href: null }} />
      <Tabs.Screen name="leaderboard" options={{ href: null }} />
      <Tabs.Screen name="settings" options={{ href: null }} />
      <Tabs.Screen name="quiz-result" options={{ href: null }} />
      <Tabs.Screen name="paid-rl" options={{ href: null }} />
      <Tabs.Screen name="syllabus-roadmap" options={{ href: null }} />
      <Tabs.Screen name="test-start" options={{ href: null }} />
    </Tabs>
  );
}