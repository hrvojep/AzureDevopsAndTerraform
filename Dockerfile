# Get Base Image (Full .NET Core SDK)
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers

COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build website
COPY . ./
RUN dotnet publish -c release -o out

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build app/out .

ENTRYPOINT ["dotnet", "watherapi.dll"]                       