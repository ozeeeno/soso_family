import json
import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify
import pymysql
from openai import OpenAI
load_dotenv()
app = Flask(__name__)
@app.route("/")
def index():
    return "Hello, World!"
@app.route("/report")
def report():
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
        # print(str(qna))
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
    return output
@app.route("/calendar")
def calendar():
    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )
    count_comment = {}
    with conn.cursor() as cursor:
        cursor.execute("SELECT date, COUNT(question) FROM Question as q, Answer a WHERE q.q_id=a.q_id GROUP BY question")
        results = cursor.fetchall()
        for result in results:
            date_str = result[0].strftime('%Y-%m-%d')
            count_comment[date_str] = result[1]
    conn.close()
    print(count_comment)
    return count_comment
@app.route("/calendar_detail")
def calendar_detail():
    date_str = request.args.get('date')
    # print("date_str!!!!")
    # print(date_str)
    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )
    query = "SELECT date, question, answer FROM Question as q, Answer a WHERE q.q_id=a.q_id and q.date = DATE(" + date_str + ")"
    with conn.cursor() as cursor:
        cursor.execute(query)
        results = cursor.fetchall()
        if not results:
            return jsonify({})
        comments = {results[0][1]:[results[0][1]]}
        for result in results:
            comments[result[1]].append(result[2])
    return comments
@app.route("/question")
def question():
    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )
    # set api key
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY"),
    )
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "가족의 소통을 위한 한 문장에 하나의 질문을 만들어줘. 입력어의 감정, 경험, 취미, 성향 등을 답변자가 추측하여 답변 할 수 있도록 질문을 만들어줘. 질문은 매일 1개 만들거고 중복되지 않도록 만들어줘 질문은 추측하여 답변할 수 있도록 만들어줘. 입력어에 맞게 질문 1개 만들어줘. 입력어: 엄마."}
        ]
    )
    output = response.choices[0].message.content
    # print(output)
    return output
@app.route("/recommend")
def recommend():
    conn = pymysql.connect(
        host="kbh-team-007.cnmgd1eiu1rn.ap-northeast-2.rds.amazonaws.com",
        user="admin",
        password="12345678",
        database="notes",
    )
    best_answer = []
    with conn.cursor() as cursor:
        cursor.execute("SELECT answer FROM Question as q, Answer a WHERE q.q_id=a.q_id and likes=(SELECT MAX(likes) FROM Answer);")
        results = cursor.fetchall()
        for result in results:
            best_answer.append(result)
    # set api key
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY"),
    )
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "지금 내가 리스트 형태로 만들어진 가족들의 성격과 취향이 기록된 리스트를 줄거야. 이 리스트를 참고해서 가족들이 좋아하고 같이 할 수 있는 취미활동을 간략하게 5개 정도 리스트로 알려줘! enter도 입력해서 깔끔하게 보이게 출력해줘!"},
            {"role": "user", "content": str(best_answer)}
        ]
    )
    output = response.choices[0].message.content
    # print(output)
    return output
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)