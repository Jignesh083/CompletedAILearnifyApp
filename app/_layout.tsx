import { Stack } from "expo-router";

export default function RootLayout() {
  return (
    <Stack
      initialRouteName="splash"
      screenOptions={{
        headerShown: false,
        animation: "fade", // smooth transition
      }}
    >
      {/* Splash Screen */}
      <Stack.Screen name="splash" />

      {/* Authentication Screens */}
      <Stack.Screen name="auth/login" />
      <Stack.Screen name="auth/register" />

      {/* Main App (Bottom Tabs) */}
      <Stack.Screen name="(tabs)" />
    </Stack>
  );
}