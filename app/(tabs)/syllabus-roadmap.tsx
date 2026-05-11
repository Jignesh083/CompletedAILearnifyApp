import { useLocalSearchParams } from 'expo-router';
import { FlatList, StyleSheet, Text, View } from 'react-native';

const ROADMAP: Record<string, string[]> = {

  DSA: [
    "Introduction to DSA",
    "Time & Space Complexity",
    "Arrays",
    "Strings",
    "Searching Algorithms",
    "Sorting Algorithms",
    "Stack",
    "Queue",
    "Linked List",
    "Trees",
    "Graphs",
  ],

  ReinforcementLearning: [
    "Introduction to RL",
    "Agent & Environment",
    "States, Actions, Rewards",
    "Policy",
    "Value Function",
    "Markov Decision Process",
    "Bellman Equation",
    "Q-Learning",
    "SARSA",
    "Deep Q Network",
  ],

  JAVA: [
    "Java Basics",
    "Variables & Data Types",
    "Control Statements",
    "OOP Concepts",
    "Inheritance",
    "Polymorphism",
    "Exception Handling",
    "Collections Framework",
  ],
};

export default function Roadmap() {

const { course } = useLocalSearchParams<{ course?: string }>();

const selectedCourse = course || "DSA";
const topics = ROADMAP[selectedCourse] || [];

if (topics.length === 0) {
  return (
    <View style={{flex:1, justifyContent:'center', alignItems:'center'}}>
      <Text>No topics available</Text>
    </View>
  );
}

  return (
    <View style={styles.container}>

      <Text style={styles.heading}>
🚀 {selectedCourse} Roadmap
      </Text>

      <FlatList
        data={topics}
        keyExtractor={(item, index) => index.toString()}
        renderItem={({ item, index }) => (
          <View style={styles.step}>
            <View style={styles.circle}>
              <Text style={styles.number}>{index + 1}</Text>
            </View>

            <Text style={styles.text}>{item}</Text>
          </View>
        )}
      />

    </View>
  );
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#F5F7FB',
  },

  heading: {
    fontSize: 20,
    fontWeight: '800',
    marginBottom: 20,
    marginTop: 40,
    color: '#123C7B',
  },

  step: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 14,
  },

  circle: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: '#123C7B',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 10,
  },

  number: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '700',
  },

  text: {
    fontSize: 15,
    fontWeight: '500',
    color: '#222',
  },

});