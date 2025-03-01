# Usar una imagen ligera de Python 3.11
FROM python:3.11-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar Poetry
RUN pip install --no-cache-dir poetry==1.8.2

# Agregar Poetry al PATH
ENV PATH="/root/.local/bin:$PATH"

# Configurar Poetry para no crear entornos virtuales dentro del contenedor
RUN poetry config virtualenvs.create false

# Copiar solo los archivos necesarios para instalar dependencias
COPY pyproject.toml poetry.lock ./

# Instalar dependencias del proyecto
RUN poetry install --no-interaction --no-ansi --no-root

# Copiar el resto del código fuente dentro de /app
COPY . .

# Asegurar permisos adecuados
RUN chmod -R 755 /app

# Exponer el puerto en el que correrá la API
EXPOSE 8000

# Comando para ejecutar la API
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
