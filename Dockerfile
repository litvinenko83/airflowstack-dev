FROM apache/airflow:2.2.2

RUN pip install --no-cache-dir \
        apache-airflow[microsoft.mssql,sentry,telegram,samba,imap,sqlite]==2.2.
        
ENV AIRFLOW__CORE__EXECUTOR=CeleryExecutor
ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN=mssql+pyodbc://airflow:airflow@db:1433/airflow?driver=ODBC+Driver+17+for+SQL+Server
ENV AIRFLOW__CELERY__RESULT_BACKEND=db+mssql://airflow:airflow@db:1433/airflow?driver=ODBC+Driver+17+for+SQL+Server
ENV AIRFLOW__CELERY__BROKER_URL=redis://:@redis:6379/0
ENV AIRFLOW__CORE__FERNET_KEY=
ENV AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION=true
ENV AIRFLOW__CORE__LOAD_EXAMPLES=true
ENV AIRFLOW__API__AUTH_BACKEND=airflow.api.auth.backend.basic_auth
#ENV AIRFLOW_UID=0
ENV _AIRFLOW_DB_UPGRADE=true
ENV _AIRFLOW_WWW_USER_CREATE=true
#ENV _AIRFLOW_WWW_USER_USERNAME=airflow
#ENV _AIRFLOW_WWW_USER_PASSWORD=airflow
#ENV DUMB_INIT_SETSID=0
#ENV TZ=Europe/Moscow
