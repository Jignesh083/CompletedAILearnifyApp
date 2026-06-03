/* ===========================
   SPLIT TOPICS
=========================== */

const splitTopics = (text) => {

  const topics = [];

  const sections = text.split(
  /\n(?=[A-Za-z].*—\s*\d+\s*Tricky.*MCQs)/g
);

  for (const section of sections) {

    const lines = section
      .split("\n")
      .map(x => x.trim())
      .filter(Boolean);

    if (!lines.length) continue;

    const topicName = lines[0]
      .replace(/—\s*\d+\s*Tricky.*MCQs/i, "")
      .trim();

    topics.push({
      topicName,
      content: lines.slice(1).join("\n")
    });

  }

  return topics;

};


/* ===========================
   GENERATE TOPIC KEY
=========================== */

const generateTopicKey = (name) => {

  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");

};


/* ===========================
   PARSE QUESTIONS
=========================== */

const parseQuestions = (text) => {

  const blocks = text.match(
    /\d+\.\s[\s\S]*?(?=\n\d+\.|\Z)/g
  ) || [];

  const questions = [];

  for (const block of blocks) {

    const questionMatch = block.match(
      /^\d+\.\s(.+?)(?=A\)|A\.)/s
    );

    if (!questionMatch) continue;

    const question = questionMatch[1].trim();

    const optionRegex =
      /([A-D])[\.\)]\s*(.*?)(?=[A-D][\.\)]|Answer:)/gs;

    const options = [];

    let m;

    while ((m = optionRegex.exec(block)) !== null) {

      options.push({
        key: m[1],
        text: m[2].trim()
      });

    }

    const answerMatch =
      block.match(/Answer:\s*([A-D])/i);

    const answer =
      answerMatch?.[1]?.toUpperCase();

    if (options.length !== 4) continue;

    questions.push({
      question,
      options: options.map(o => ({
        text: o.text,
        isCorrect: o.key === answer
      })),
      explanation: ""
    });

  }

  return questions;
};


module.exports = {
  splitTopics,
  parseQuestions,
  generateTopicKey
};