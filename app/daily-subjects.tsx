import { useRouter } from 'expo-router';
import { Pressable, StyleSheet, Text, View } from 'react-native';

const SUBJECTS = [
  { id: 'dsa', title: 'DSA' },
  { id: 'rl', title: 'Reinforcement Learning' },
  { id: 'java', title: 'Java' },
];

export default function DailySubjects() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Select Subject</Text>

      {SUBJECTS.map((subject) => (
        <Pressable
          key={subject.id}
          style={styles.card}
          onPress={() =>
            router.push({
              pathname: '/daily-quiz',
              params: {
                subject: subject.id,   // ⭐ VERY IMPORTANT
              },
            })
          }
        >
          <Text style={styles.cardText}>{subject.title}</Text>
        </Pressable>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#F5F7FB',
  },

  title: {
    marginTop: 30,
    fontSize: 24,
    fontWeight: '800',
    marginBottom: 20,
    color: '#123C7B',
    letterSpacing: 0.5,
  },

  card: {
    padding: 18,
    backgroundColor: '#ffffff',
    borderRadius: 16,
    marginBottom: 14,

    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 3,

    borderLeftWidth: 4,
    borderLeftColor: '#123C7B',
  },

  cardText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#222',
  },

});