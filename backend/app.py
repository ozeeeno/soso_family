import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify
import pymysql
from openai import OpenAI

load_dotenv()

app = Flask(__name__)
@app.route("/")
def index():
    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )
    with conn.cursor() as cursor:
        cursor.execute("SELECT date, question, answer, likes FROM Question as q, Answer as a WHERE q.q_id=a.q_id and q.member=2 and month(q.date)=1")
        result = cursor.fetchall()
        print(result)
    return "Hello, World!"

@app.route("/generate")
def generate():
    #data = request.get_json()
    #prompt = data["prompt"]

    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )

    qna = {}

    with conn.cursor() as cursor:
        cursor.execute("SELECT date, question, answer, likes FROM Question as q, Answer as a WHERE q.q_id=a.q_id and q.member=2 and month(q.date)=1")
        results = cursor.fetchall()

        for result in results:
            if result[1] not in qna.keys():
                qna[result[1]] = [result[2]]
            else:
                qna[result[1]].append(result[2])

        print(str(qna))
    

    # set api key
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY"),
    )

    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "지금 내가 딕셔너리 형태로 만들어진 질의응답 리스트를 줄거야. key에 질문, value에 답변 list가 저장되어 있어. 이 질문은 모두 엄마한테 한 질문이고 답변은 가족구성원들이 엄마를 생각하면서 답했어. 이 딕셔너리를 참고해서 100자 이하로 자연스럽게 요약해줘."},
            {"role": "user", "content": str(qna)}
        ]
    )
    output = response.choices[0].message.content
    # print(output)
    return jsonify({"response": output})
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)