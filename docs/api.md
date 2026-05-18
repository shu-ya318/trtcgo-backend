# TrtcGo - Backend API Specification

## Shared Error Response Format
```json
{
  "error": {
    "message": "Detailed error message"
  }
}
```

---

### Users

#### Create User 
- **Endpoint**: `/users/create-user`
- **Request Body**:
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "name":"test"
  }
}
```
- **Response (200 OK)**:
```json
{
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "test",
    "tier_id": 1,
    "role_id": 1,
    "status_code": "active",
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

#### Login User 
- **Endpoint**: `/users/login-user`
- **Request Body**:
```json
{
  "credentials": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```
- **Response (200 OK)**:
```json
{
  "token": "jwt_token_string",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name":"test",
    "last_login_at": "2023-01-01T00:00:00Z"
  }
}
```

#### Get User Profile
- **Endpoint**: `/users/get-profile`
- **Request Body**:
```json
{}
```
- **Response (200 OK)**:
```json
{
  "user": {
    "id": 1,
    "email": "user@example.com",
    "tier_id": 1,
    "status_code": "active"
  }
}
```

#### Update User Profile
- **Endpoint**: `/users/update-profile`
- **Request Body**:
```json
{
  "user": {
    "name": "newName",
    "password": "newpassword123"
  }
}
```
- **Response (200 OK)**:
```json
{
  "user": {
    "id": 1,
    "email": "newemail@example.com",
    "tier_id": 1,
    "status_code": "active",
    "updated_at": "2023-01-02T00:00:00Z"
  }
}
```

---

### Stations

#### Get Station List
- **Endpoint**: `/stations/get-list`
- **Request Body**:
```json
{}
```
- **Response (200 OK)**:
```json
{
  "stations": [
    {
      "id": 1,
      "code": "BL12",
      "name_zh_tw": "台北車站",
      "name_en": "Taipei Main Station",
      "status_code": "active"
    }
  ]
}
```

#### Get Station Details
Includes basic station info (`station_infos`), exits (`station_exits`), facilities (`station_facilities`), etc.
- **Endpoint**: `/stations/get-details`
- **Request Body**:
```json
{
  "station": {
    "id": 1
  }
}
```
- **Response (200 OK)**:
```json
{
  "station": {
    "id": 1,
    "code": "BL12",
    "name_zh_tw": "台北車站",
    "infos": [
      { "category_type_id": 1, "status_code": "active" }
    ],
    "exits": [
      { "id": 1, "exit_code": "M1", "has_elevator": true }
    ],
    "facilities": [
      { "id": 1, "facility_type_id": 2, "floor": "B1" }
    ]
  }
}
```

#### Query Fares
- **Endpoint**: `/stations/get-fares`
- **Request Body**:
```json
{
  "fare_query": {
    "origin_station_id": 1,
    "destination_station_id": 2
  }
}
```
- **Response (200 OK)**:
```json
{
  "fares": [
    {
      "ticket_type_code": "adult",
      "price": 20
    }
  ]
}
```

#### Query Travel Times
- **Endpoint**: `/stations/get-travel-times`
- **Request Body**:
```json
{
  "travel_time_query": {
    "from_station_id": 1,
    "to_station_id": 2
  }
}
```
- **Response (200 OK)**:
```json
{
  "travel_times": [
    {
      "line_id": 1,
      "run_time_seconds": 120,
      "stop_time_seconds": 30
    }
  ]
}
```

---

### User Station Bookmarks

#### Add Bookmark
- **Endpoint**: `/user-station-bookmarks/create-bookmark`
- **Request Body**:
```json
{
  "bookmark": {
    "station_id": 1
  }
}
```
- **Response (200 OK)**:
```json
{
  "bookmark": {
    "id": 1,
    "user_id": 1,
    "station_id": 1,
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

#### Get Bookmark List
- **Endpoint**: `/user-station-bookmarks/get-list`
- **Request Body**:
```json
{}
```
- **Response (200 OK)**:
```json
{
  "bookmarks": [
    {
      "id": 1,
      "station_id": 1,
      "created_at": "2023-01-01T00:00:00Z"
    }
  ]
}
```

#### Delete Bookmark
- **Endpoint**: `/user-station-bookmarks/delete-bookmark`
- **Request Body**:
```json
{
  "bookmark": {
    "id": 1
  }
}
```
- **Response (200 OK)**:
```json
{
  "success": true
}
```

---

### User Trip Plans

#### Create Trip Plan
- **Endpoint**: `/user-trip-plans/create-plan`
- **Request Body**:
```json
{
  "trip_plan": {
    "start_station_id": 1,
    "end_station_id": 5,
    "fare": 30,
    "travel_time_minutes": 15,
    "transfer_count": 1,
    "notes": "Commute route",
    "facility_ids": [1, 2]
  }
}
```
- **Response (200 OK)**:
```json
{
  "trip_plan": {
    "id": 1,
    "user_id": 1,
    "start_station_id": 1,
    "end_station_id": 5,
    "fare": 30,
    "travel_time_minutes": 15,
    "transfer_count": 1,
    "notes": "Commute route",
    "facilities": [
      { "facility_id": 1 },
      { "facility_id": 2 }
    ],
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

#### Get Trip Plan List
- **Endpoint**: `/user-trip-plans/get-list`
- **Request Body**:
```json
{}
```
- **Response (200 OK)**:
```json
{
  "trip_plans": [
    {
      "id": 1,
      "start_station_id": 1,
      "end_station_id": 5,
      "notes": "Commute route",
      "created_at": "2023-01-01T00:00:00Z"
    }
  ]
}
```

#### Get Trip Plan Details
- **Endpoint**: `/user-trip-plans/get-plan`
- **Request Body**:
```json
{
  "trip_plan": {
    "id": 1
  }
}
```
- **Response (200 OK)**:
```json
{
  "trip_plan": {
    "id": 1,
    "user_id": 1,
    "start_station_id": 1,
    "end_station_id": 5,
    "fare": 30,
    "travel_time_minutes": 15,
    "transfer_count": 1,
    "notes": "Commute route",
    "facilities": [
      { "facility_id": 1 },
      { "facility_id": 2 }
    ],
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

#### Update Trip Plan
- **Endpoint**: `/user-trip-plans/update-plan`
- **Request Body**:
```json
{
  "trip_plan": {
    "id": 1,
    "notes": "Updated notes"
  }
}
```
- **Response (200 OK)**:
```json
{
  "trip_plan": {
    "id": 1,
    "user_id": 1,
    "start_station_id": 1,
    "end_station_id": 5,
    "fare": 30,
    "travel_time_minutes": 15,
    "transfer_count": 1,
    "notes": "Updated notes",
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-02T00:00:00Z"
  }
}
```

#### Delete Trip Plan
- **Endpoint**: `/user-trip-plans/delete-plan`
- **Request Body**:
```json
{
  "trip_plan": {
    "id": 1
  }
}
```
- **Response (200 OK)**:
```json
{
  "success": true
}
```

---

### User Chat Messages

#### Send Message
- **Endpoint**: `/user-chat-messages/create-message`
- **Request Body**:
```json
{
  "message": {
    "chat_type_code": "general",
    "message_content": "Where is the lost and found center?"
  }
}
```
- **Response (200 OK)**:
```json
{
  "message": {
    "id": 1,
    "user_id": 1,
    "admin_id": null,
    "chat_type_code": "general",
    "sender_type_code": "user",
    "message_content": "Where is the lost and found center?",
    "created_at": "2023-01-01T12:00:00Z"
  }
}
```

#### Get Message List
- **Endpoint**: `/user-chat-messages/get-list`
- **Request Body**:
```json
{
  "query": {
    "limit": 50,
    "offset": 0
  }
}
```
- **Response (200 OK)**:
```json
{
  "messages": [
    {
      "id": 1,
      "user_id": 1,
      "sender_type_code": "user",
      "message_content": "Where is the lost and found center?",
      "created_at": "2023-01-01T12:00:00Z"
    }
  ]
}
```
