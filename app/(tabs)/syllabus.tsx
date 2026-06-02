import { useRouter } from 'expo-router';
import { Pressable, StyleSheet, Text, View } from 'react-native';

const COURSES = [
  { id: 'DSA', title: 'DSA' },
  { id: 'ReinforcementLearning', title: 'Reinforcement Learning' },
  { id: 'JAVA', title: 'Java' },
];
//hello
export default function Syllabus() {
  const router = useRouter();

  return (
    <View style={styles.container}>

      <Text style={styles.heading}>📘 Select Course</Text>

      {COURSES.map((course) => (
        <Pressable
          key={course.id}
          style={styles.card}
          onPress={() =>
            router.push({
              pathname: '/syllabus-roadmap',
              params: { course: course.id },
            })
          }
        >
          <Text style={styles.title}>{course.title}</Text>
        </Pressable>
      ))}

    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 20, backgroundColor: '#F5F7FB' },

  heading: {
    fontSize: 22,
    fontWeight: '800',
    marginBottom: 20,
    marginTop: 40,
    color: '#123C7B',
  },

  card: {
    backgroundColor: '#123C7B',
    padding: 20,
    borderRadius: 14,
    marginBottom: 14,
  },

  title: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '700',
  },
});