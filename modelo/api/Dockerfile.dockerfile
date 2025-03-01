# Usar una imagen ligera de Python 3.11
FROM python:3.11-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /api

# Instalar Poetry
RUN pip install --no-cache-dir poetry==1.8.2

# Agregar Poetry al PATH
ENV PATH="/root/.local/bin:$PATH"

# Configurar Poetry para no crear entornos virtuales dentro del contenedor
RUN poetry config virtualenvs.create false

# Copiar solo los archivos necesarios para instalar dependencias
COPY pyproject.toml poetry.lock ./

# Instalar dependencias del proyecto sin instalar el paquete raíz
RUN poetry install --no-root --no-interaction --no-ansi

# Copiar el resto del código fuente
COPY . .

# Asegurar que los permisos sean correctos (opcional)
RUN chmod -R 755 /api

# Exponer el puerto en el que correrá la API
EXPOSE 8000

# Comando para ejecutar la API con Uvicorn
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
