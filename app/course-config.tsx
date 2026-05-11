/* =====================================================
   TYPES
===================================================== */
export type CourseId = 'DSA' | 'CPP' | 'JAVA' | 'PYTHON' | 'OS' | 'REINFORCEMENT_LEARNING';

export type TopicType = 'quiz' | 'video';

export type Topic = {
  id: string;
  title: string;
  type: TopicType;
  maxQuestions?: number;   // 🔥 limit per quiz
  timeLimitSec?: number;   // 🔥 timer (future)
};

/* =====================================================
   COURSE → TOPIC MAP (🔥 SCALABLE CORE)
===================================================== */
export const COURSE_TOPICS: Readonly<Record<CourseId, readonly Topic[]>> = {
  DSA: [
    { id: 'dsa_intro', title: 'DSA Introduction', type: 'quiz', maxQuestions: 20 },
    { id: 'time_space', title: 'Time & Space Complexity', type: 'quiz', maxQuestions: 20 },
    { id: 'arrays', title: 'Arrays Basics', type: 'quiz', maxQuestions: 20 },
    { id: 'strings', title: 'Strings Basics', type: 'quiz', maxQuestions: 20 },
    { id: 'searching', title: 'Searching Algorithms', type: 'quiz', maxQuestions: 20 },
    { id: 'sorting', title: 'Sorting Algorithms', type: 'quiz', maxQuestions: 20 },
    { id: 'maths', title: 'Basic Mathematics', type: 'quiz', maxQuestions: 20 },
    { id: 'stack', title: 'Stack (Introduction)', type: 'quiz', maxQuestions: 20 },
    { id: 'queue', title: 'Queue (Introduction)', type: 'quiz', maxQuestions: 20 },
    { id: 'practice', title: 'Practice Problems', type: 'quiz', maxQuestions: 20 },
  ],

REINFORCEMENT_LEARNING: [
  { id: 'rl_intro', title: 'RL Introduction & Basics', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_core_concepts', title: 'RL Core Concepts', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_reinforcement_types', title: 'RL Approaches & Types', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_elements', title: 'Core Elements of RL', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_mdp', title: 'Bellman Equation & MDP', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_bellman', title: 'Bellman Equation', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_qlearning', title: 'Q-Learning (Model-Free)', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_sarsa', title: 'SARSA & Q-Learning Comparison', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_policy_types', title: 'On-Policy vs Off-Policy', type: 'quiz', maxQuestions: 20 },
  { id: 'rl_dqn', title: 'Deep Reinforcement Learning (DQN)', type: 'quiz', maxQuestions: 20 },
],
  CPP: [
    { id: 'cpp_intro', title: 'C++ Introduction', type: 'quiz' },
  ],

  JAVA: [
    { id: 'java_intro', title: 'Java Introduction', type: 'quiz' },
  ],

  PYTHON: [
    { id: 'python_intro', title: 'Python Introduction', type: 'quiz' },
  ],

  OS: [
    { id: 'os_intro', title: 'Operating System Basics', type: 'quiz' },
  ],
} as const;

/* =====================================================
   FAST SELECTORS (🔥 TYPE-SAFE & NO RE-RENDER COST)
===================================================== */
export const getTopicsByCourse = (courseId: CourseId): readonly Topic[] => {
  return COURSE_TOPICS[courseId];
};

export const getTopicConfig = (
  courseId: CourseId,
  topicId: string
): Topic | undefined => {
  return COURSE_TOPICS[courseId].find(
    (t) => t.id === topicId
  );
};

/* =====================================================
   GLOBAL FLAGS (🔥 FUTURE BACKEND SWITCH)
===================================================== */
export const APP_CONFIG = {
  quiz: {
    shuffleQuestions: true,
    shuffleOptions: true,
    resumeEnabled: true,
    showScoreInstantly: false,
  },
} as const;

export default {};
