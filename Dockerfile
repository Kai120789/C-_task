# Используем официальный образ .NET SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл решения и проекты
COPY Task..sln ./
COPY Task.Connector/*.csproj ./Task.Connector/
COPY Task.Connector.Tests/*.csproj ./Task.Connector.Tests/

# Восстанавливаем зависимости
RUN dotnet restore

# Копируем все исходные файлы
COPY . ./

# Строим приложение
RUN dotnet build -c Release -o /app/build

# Публикуем как самодостаточное приложение для Linux x64
RUN dotnet publish -c Release -r linux-x64 --self-contained true -o /app/publish


# Создаем финальный образ с использованием .NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app

# Копируем опубликованные файлы
COPY --from=build /app/publish .

# Запускаем миграции при создании контейнера
CMD ["dotnet", "Task.Integration.Data.DbCreationUtility.dll", "-s", "Host=postgres;Port=5432;Database=testDb;Username=testUser;Password=813G76vT71v8;", "-p", "POSTGRE"]

# Запускаем приложение
ENTRYPOINT ["dotnet", "Task.Connector.dll"]
