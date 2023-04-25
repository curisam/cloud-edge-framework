from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from fastapi.responses import RedirectResponse, HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from typing import List
import sqlite3
from datetime import datetime


#--------------------------------------------------------------
# Code
#--------------------------------------------------------------

class TodoBase(BaseModel):
    title: str
    description: str
    done: bool
    
class TodoUpdate(BaseModel):
    title: str
    description: str
    done: bool
    updated_at: str

class TodoListup(BaseModel):
    id : str
    title: str
    description: str
    created_at: str
    updated_at: str
    done: bool

class Database:
    def __init__(self):
        self.conn = sqlite3.connect('todo.db')
        self.create_table()

    def create_table(self):
        query = '''CREATE TABLE IF NOT EXISTS todos 
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                     title TEXT NOT NULL, 
                     description TEXT NOT NULL, 
                     done BOOLEAN NOT NULL DEFAULT False,
                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'''
        self.conn.execute(query)

    def get_all_todos(self):
        query = "SELECT * FROM todos"
        cursor = self.conn.execute(query)
        todos = []
        for row in cursor:
            todo = {'id': row[0], 'title': row[1], 'description': row[2], 'done': row[3], 'created_at': row[4], 'updated_at': row[5]}
            todos.append(todo)
        return todos

    def get_todo_by_id(self, todo_id):
        query = f"SELECT * FROM todos WHERE id = {todo_id}"
        cursor = self.conn.execute(query)
        row = cursor.fetchone()
        if row:
            todo = {'id': row[0], 'title': row[1], 'description': row[2], 'done': row[3], 'created_at': row[4], 'updated_at': row[5]}
            return todo
        else:
            raise HTTPException(status_code=404, detail="Todo not found")

    def create_todo(self, todo):     
        created_at = datetime.now()
        updated_at = datetime.now()
        query = f"INSERT INTO todos (title, description, created_at, updated_at, done) VALUES ('{todo.title}', '{todo.description}', '{created_at}', '{updated_at}', {todo.done})"
        cursor = self.conn.execute(query)
        self.conn.commit()
        return self.get_todo_by_id(cursor.lastrowid)

    def update_todo_by_id(self, todo_id, todo):
        updated_at = datetime.now()
        query = f"UPDATE todos SET title = '{todo.title}', description = '{todo.description}', done = {todo.done}, updated_at = '{updated_at}' WHERE id = {todo_id}"
        #query = f"UPDATE todos SET title = '{todo.title}', description = '{todo.description}', done = {todo.done} WHERE id = {todo_id}"
        cursor = self.conn.execute(query)
        self.conn.commit()
        return self.get_todo_by_id(todo_id)

    def delete_todo_by_id(self, todo_id):
        query = f"DELETE FROM todos WHERE id = {todo_id}"
        cursor = self.conn.execute(query)
        self.conn.commit()
        if cursor.rowcount > 0:
            return JSONResponse(status_code=204)
        else:
            raise HTTPException(status_code=404, detail="Todo not found")


            
#--------------------------------------------------------------
# API
#--------------------------------------------------------------
app = FastAPI()
db = Database()

'''
# Serve the index.html file from the "static" directory
app.mount("/", StaticFiles(directory="static", html=True), name="static")

# Endpoint for serving the index.html file
@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    return request.app.mounts[0].app(request.scope, request.receive)
'''

# Redirection
@app.get("/", include_in_schema=False)
async def root():
    return RedirectResponse(url='/docs')

@app.get("/api/todos", response_model=List[TodoListup])
async def get_all_todos():
    print('hi')
    try:
        todos = db.get_all_todos()
        return todos
    except HTTPException as ex:
        raise ex

@app.get("/api/todos/{todo_id}", response_model=TodoListup)
async def get_todo_by_id(todo_id: int):
    try:
        todo = db.get_todo_by_id(todo_id)
        return todo
    except HTTPException as ex:
        raise ex

@app.post("/api/todos/create", response_model=TodoListup)
async def create_todo(todo: TodoBase):
    try:
        new_todo = db.create_todo(todo)
        return new_todo
    except HTTPException as ex:
        raise ex

@app.put("/api/todos/update/{todo_id}", response_model=TodoListup)
async def update_todo_by_id(todo_id: int, todo: TodoBase):
    try:
        updated_todo = db.update_todo_by_id(todo_id, todo)
        return updated_todo
    except HTTPException as ex:
        raise ex
        
@app.delete("/api/todos/delete/{todo_id}")
async def delete_todo_by_id(todo_id: int):
    try:
        response = db.delete_todo_by_id(todo_id)
        return response
    except HTTPException as ex:
        raise ex

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8004)