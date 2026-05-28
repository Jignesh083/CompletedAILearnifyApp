/* ===========================
   SPLIT TOPICS
=========================== */

const splitTopics = (text) => {

  const topics = [];

  topics.push({
    topicName: "Uploaded Topic",
    content: text
  });

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

  const blocks = text.split(/\n\d+\./);

  const questions = [];

  for (let b of blocks) {

    b = b.trim();

    if (!b) continue;

    const lines = b
      .split("\n")
      .map(x => x.trim())
      .filter(Boolean);

    console.log(lines);

    if (lines.length < 5) continue;

    // QUESTION
    const question = lines[0].trim();

    const options = [];

    let answer = "";

    for (let line of lines.slice(1)) {

      // OPTIONS
      if (
        line.startsWith("A.") || line.startsWith("A)") ||
        line.startsWith("B.") || line.startsWith("B)") ||
        line.startsWith("C.") || line.startsWith("C)") ||
        line.startsWith("D.") || line.startsWith("D)")
      ) {

        options.push({
          text: line.substring(2).trim(),
          key: line[0]
        });

      }

      // ANSWER
      if (
        line.toUpperCase().startsWith("ANSWER")
      ) {

        answer = line
          .split(":")[1]
          ?.trim()
          ?.charAt(0)
          ?.toUpperCase();

      }

    }

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