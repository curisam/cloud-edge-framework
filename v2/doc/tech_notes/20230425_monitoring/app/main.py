#  RUN :: 
#  python -m uvicorn main:app --reload

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from fastapi.responses import RedirectResponse, HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from typing import List
import sqlite3
from datetime import datetime
from os import environ
import json
from typing import Optional


#--------------------------------------------------------------
# Code
#--------------------------------------------------------------

class EdgeBase(BaseModel):
    name: str    
    host: str    
    port: int
    description: str
    done: bool
    
class EdgeUpdate(BaseModel):
    name: str  
    host: str    
    port: int
    description: str
    done: bool
    updated_at: str

class EdgeListup(BaseModel):
    id : str
    name: str  
    host: str    
    port: int
    description: str
    created_at: str
    updated_at: str
    done: bool

    
class Database:
    def __init__(self): 
        self.conn = sqlite3.connect('edges.db')
        self.create_table()

        
    def create_table(self):
        query = '''CREATE TABLE IF NOT EXISTS edges 
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                     name TEXT NOT NULL, 
                     host TEXT NOT NULL, 
                     port INTEGER NOT NULL, 
                     description TEXT NOT NULL, 
                     done BOOLEAN NOT NULL DEFAULT False,
                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'''
        self.conn.execute(query)

        
    def get_all_edges(self):
        query = "SELECT * FROM edges"
        cursor = self.conn.execute(query)
        edges = []
        for row in cursor:
            edge = {'id': row[0], 'name': row[1], 'host': row[2],  'port': row[3], 'description': row[4], 'done': row[5], 'created_at': row[6], 'updated_at': row[7]}
            edges.append(edge)
        return edges

    
    def get_edge_by_id(self, edge_id):
        query = f"SELECT * FROM edges WHERE id = {edge_id}"
        cursor = self.conn.execute(query)
        row = cursor.fetchone()
        if row:
            edge = {'id': row[0], 'name': row[1], 'host': row[2],  'port': row[3], 'description': row[4], 'done': row[5], 'created_at': row[6], 'updated_at': row[7]}
            return edge
        else:
            raise HTTPException(status_code=404, detail="Edge not found")

            
    def create_edge(self, edge):     
        created_at = datetime.now()
        updated_at = datetime.now()
        query = f"INSERT INTO edges (name, host, port, description, created_at, updated_at, done) VALUES ('{edge.name}', '{edge.host}', {edge.port}, '{edge.description}', '{created_at}', '{updated_at}', {edge.done})"
        cursor = self.conn.execute(query)
        self.conn.commit()
        return self.get_edge_by_id(cursor.lastrowid)

    
    def update_edge_by_id(self, edge_id, edge):
        updated_at = datetime.now()
        
        print(f'updated_at = {updated_at}')
        
        query = f"UPDATE edges SET name = '{edge.name}', host = '{edge.host}', port = {edge.port}, description = '{edge.description}', done = {edge.done}, updated_at = '{updated_at}' WHERE id = {edge_id}"
        
        print(f'query = {query}')
        cursor = self.conn.execute(query)
        self.conn.commit()
        return self.get_edge_by_id(edge_id)

    
    def delete_edge_by_id(self, edge_id):
        query = f"DELETE FROM edges WHERE id = {edge_id}"
        cursor = self.conn.execute(query)
        self.conn.commit()
        if cursor.rowcount > 0:
            return JSONResponse(status_code=204)
        else:
            raise HTTPException(status_code=404, detail="Edge not found")


            
#--------------------------------------------------------------
# API
#--------------------------------------------------------------
app = FastAPI()
db = Database()

# Redirection
@app.get("/", include_in_schema=False)
async def root():
    return RedirectResponse(url='/docs')

@app.get("/api/edges", response_model=List[EdgeListup])
async def get_all_edges():
    print('hi')
    try:
        edges = db.get_all_edges()
        return edges
    except HTTPException as ex:
        raise ex

@app.get("/api/edges/{edge_id}", response_model=EdgeListup)
async def get_edge_by_id(edge_id: int):
    try:
        edge = db.get_edge_by_id(edge_id)
        return edge
    except HTTPException as ex:
        raise ex

@app.post("/api/edges/create", response_model=EdgeListup)
async def create_edge(edge: EdgeBase):
    try:
        new_edge = db.create_edge(edge)
        return new_edge
    except HTTPException as ex:
        raise ex

@app.put("/api/edges/update/{edge_id}", response_model=EdgeListup)
async def update_edge_by_id(edge_id: int, edge: EdgeBase):
    try:
        updated_edge = db.update_edge_by_id(edge_id, edge)
        return updated_edge
    except HTTPException as ex:
        raise ex
        
@app.delete("/api/edges/delete/{edge_id}")
async def delete_edge_by_id(edge_id: int):
    try:
        response = db.delete_edge_by_id(edge_id)
        return response
    except HTTPException as ex:
        raise ex
        

@app.get("/get_api_key")
def get_api_key():
    api_key = ""    
    
    try:
        with open('appconfig.conf') as f:
            js = json.load(f)
            api_key = js["api_key"]
            return {"api_key": api_key}

    except IOError:
        print("appconfig.conf not accessible")

    return {"API_KEY: {}".format(api_key)}



if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8004)