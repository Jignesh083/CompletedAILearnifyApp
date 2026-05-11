import { API } from "../config/api";

export type QuizQuestion = {
  id: number;
  question: string;
  options: {
    id: number;
    option_text: string;
    is_correct: boolean;
  }[];
};

async function loadFromAPI(
  topicId: string,
  page: number,
  limit: number
): Promise<QuizQuestion[]> {

  try {

    const res = await fetch(
      `${API}/quiz/${topicId}?page=${page}&limit=${limit}`
    );

    if (!res.ok) {
      console.log("API ERROR STATUS:", res.status);
      return [];
    }

    const data = await res.json();

    console.log("RAW API DATA:", data);

    // ✅ FIXED: handle all possible backend response shapes
    const list = Array.isArray(data)
      ? data
      : data?.data || data?.questions || data?.result || [];

    console.log("FINAL LIST:", list);

    const formatted: QuizQuestion[] = list.map((q: any) => ({

      id: q.id,
      question: q.question,

      // ✅ SAFE options handling (no crash)
      options: (q.options || []).map((o: any) => ({
        id: o.id,
        option_text: o.text,

        // ✅ HARD BOOLEAN NORMALIZATION
        is_correct: Boolean(
          o.is_correct === true ||
          o.is_correct === 1 ||
          o.is_correct === "1" ||
          o.is_correct === "true"
        )
      }))

    }));

    console.log("FORMATTED QUESTIONS:", formatted);

    return formatted;

  } catch (err) {

    console.log("QUIZ API ERROR:", err);
    return [];

  }
}

export async function getQuizByTopic(
  topicId: string,
  page: number = 1,
  limit: number = 20
): Promise<QuizQuestion[]> {

  return await loadFromAPI(topicId, page, limit);

}