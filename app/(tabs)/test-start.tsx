import { useLocalSearchParams } from 'expo-router';
import { StyleSheet, Text, View } from 'react-native';

export default function TestStart() {

  const { title } = useLocalSearchParams();

  const safeTitle = title || "Test";   // ✅ fallback

  return (
    <View style={styles.container}>

      <Text style={styles.title}>🚀 {safeTitle}</Text>

      <Text style={styles.desc}>
        This test feature is currently under development. Please check back later.
      </Text>

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5F7FB',   // ✅ important (no blank feel)
    padding: 20,
  },

  title: {
    fontSize: 20,
    fontWeight: '700',
    marginBottom: 10,
  },

  desc: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',   // ✅ better UI
  },
});