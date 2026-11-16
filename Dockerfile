FROM python:3.12-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
EXPOSE 50072
CMD ["python", "app.py"]


# Nota aluno A: Nos dias 09, 10 e 11 estive viajando a trabalho, sem a possibilidade de realização da atividade, o aluno B esteve realizou as etapas necessarias para a execução em aula.