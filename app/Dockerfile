FROM python:3.11-slim

# Usamos el directorio actual como directorio de trabajo
WORKDIR /api


RUN pip install poetry==1.8.2

# Agregar Poetry al PATH
ENV PATH="/root/.local/bin:$PATH"

# Configurar Poetry para no crear un entorno virtual
RUN poetry config virtualenvs.create false

# Copiar los archivos de configuración de Poetry
COPY pyproject.toml poetry.lock ./

# Instalar dependencias
RUN poetry lock && poetry install

# Copiar el resto de la aplicación
COPY . .

# Exponer el puerto de la API
EXPOSE 8000

# Comando para iniciar la API
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]