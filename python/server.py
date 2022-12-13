from flask import Flask, jsonify
from flask_socketio import SocketIO, emit, join_room, leave_room

# Flask App Config
app: Flask = Flask(__name__)

app.config["SECRET_KEY"] = "secret"
app.config["SESSION_TYPE"] = "filesystem"

# CORS_ALLOWED_ORIGINS is the list of origins authorized to make requests.
socketio = SocketIO(app, cors_allowed_origins="*")


# Home
@app.route("/", methods=["GET", "POST"])
def index():
    return jsonify({"data": "MineCraft SocketIO Server"})


# Join WebSocket
@socketio.on("join", namespace="/mcpe")
def join(message):
    name = message["name"]

    join_room(name)
    print(f"{name} joined room.")

    emit("message", {"msg": f"Successfully connected to Socket."}, room=name)


# Action Detected on SmartPhone
@socketio.on("action", namespace="/mcpe")
def text(message):
    name = message["name"]
    action = message["action"]

    print(f"action detected : {action}")

    emit("message", {"msg": f"{action} detected."}, room=name)


# RUN
if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", debug=True)
