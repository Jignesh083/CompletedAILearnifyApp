import { useRouter } from 'expo-router';
import { FlatList, Pressable, StyleSheet, Text, View } from 'react-native';

const TESTS = [
  { id: 'dsa_test_1', title: 'DSA Mock Test 1' },
  { id: 'dsa_test_2', title: 'DSA Mock Test 2' },
  { id: 'rl_test_1', title: 'RL Mock Test 1' },
  { id: 'java_test_1', title: 'Java Mock Test 1' },
];

export default function TestSeries() {
  const router = useRouter();

  return (
    <View style={styles.container}>

      <Text style={styles.heading}>📝 Test Series</Text>

      {TESTS.length === 0 ? (
  <View style={{flex:1, justifyContent:'center', alignItems:'center'}}>
    <Text>No tests available</Text>
  </View>
) : (
  <FlatList
    data={TESTS}
    keyExtractor={(item) => item.id}
    renderItem={({ item }) => (
      <Pressable
        style={styles.card}
        onPress={() =>
          router.push({
            pathname: '/(tabs)/test-start',
            params: { testId: item.id, title: item.title },
          })
        }
      >
        <Text style={styles.title}>{item.title}</Text>
        <Text style={styles.sub}>Start Test</Text>
      </Pressable>
    )}
  />
)}

    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 20, backgroundColor: '#F5F7FB' },

  heading: {
    fontSize: 22,
    fontWeight: '800',
    marginTop: 40,
    marginBottom: 20,
    color: '#123C7B',
  },

  card: {
    backgroundColor: '#fff',
    padding: 18,
    borderRadius: 14,
    marginBottom: 14,
  },

  title: {
    fontSize: 16,
    fontWeight: '700',
    color: '#123C7B',
  },

  sub: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
});