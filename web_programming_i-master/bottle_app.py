import datetime
import time
import uuid
import dataset
import json
import os

db = dataset.connect('sqlite:///todo.db')

from bottle import get, post, request, response, template, redirect, TEMPLATE_PATH

ON_PYTHONANYWHERE = "PYTHONANYWHERE_DOMAIN" in os.environ.keys()



if ON_PYTHONANYWHERE:
    from bottle import default_app
    base_url = "http://jaimie6453.pythonanywhere.com/"
else:
    from bottle import run, debug
    base_url = "http://localhost:8080/"


def get_session(request, response):
    session_id = request.cookies.get("session_id",None)
    if session_id == None:
        session_id = str(uuid.uuid4())
        session = { 'session_id':session_id, "username":"Guest", "time":int(time.time()) }
        db['session'].insert(session)
        response.set_cookie("session_id",session_id)
    else:
        session=db['session'].find_one(session_id=session_id)
        if session == None:
            session_id = str(uuid.uuid4())
            session = { 'session_id':session_id, "username":"Guest", "time":int(time.time()) }
            db['session'].insert(session)
            response.set_cookie("session_id",session_id)

            # session = {"message":"no session found with the id =" + session_id}
    return session

def save_session(session):
    db['session'].update(session,['session_id'])

@get('/login')
def get_login():
    print("starting session")
    session = get_session(request, response)
    if session['username'] != 'Guest':
        redirect('/')
        return
    print("hello")
    return template("login", csrf_token="abcrsrerredadfa")

@post('/login')
def post_login():
    session = get_session(request, response)
    if session['username'] != 'Guest':
        redirect('/')
        return
    # csrf_token = request.forms.get("csrf_token").strip()
    # if csrf_token != "abcrsrerredadfa":
    #     redirect('/login_error')
    #     return
    username = request.forms.get("username").strip()
    password = request.forms.get("password").strip()
    profile = db['profile'].find_one(username=username)
    if profile == None:
        redirect('/login_error')
        return
    if password != profile["password"]:
        redirect('/login_error')
        return
    session['username'] = username
    save_session(session)
    redirect('/')

@get('/login_error')
def get_login_error():
    return template("login_error")

@get('/logout')
def get_logout():
    session = get_session(request, response)
    session['username'] = 'Guest'
    save_session(session)
    redirect('/login')

@get('/register')
def get_register():
    session = get_session(request, response)
    if session['username'] != 'Guest':
        redirect('/')
        return
    return template("register", csrf_token="abcrsrerredadfa")

@post('/register')
def post_register():
    session = get_session(request, response)
    if session['username'] != 'Guest':
        redirect('/')
        return
    # csrf_token = request.forms.get("csrf_token").strip()
    # if csrf_token != "abcrsrerredadfa":
    #     redirect('/login_error')
    #     return
    username = request.forms.get("username").strip()
    password = request.forms.get("password").strip()
    if len(password) < 8:
        redirect('/login_error')
        return
    profile = db['profile'].find_one(username=username)
    if profile:
        redirect('/login_error')
        return
    db['profile'].insert({'username':username, 'password':password})
    redirect('/')

@get('/')
def get_show_list_ajax():
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    print(base_url)
    return template("home", base_url=base_url)

@get('/get_tasks')
def get_get_tasks():
    session = get_session(request, response)
    response.content_type = 'application/json'
    if session['username'] == 'Guest':
        return "[]"
    else:
        result = db['todo'].find(status=False)
        tasks= [dict(r) for r in result]
        text = json.dumps(tasks)
        return text

@get('/get_completed_tasks')
def get_get_completed_tasks():
    session = get_session(request, response)
    response.content_type = 'application/json'
    if session['username'] == 'Guest':
        return "[]"
    else:
        result = db['todo'].find(status=True)
        tasks= [dict(r) for r in result]
        print("get_completed_tasks length ", len(tasks))
        text = json.dumps(tasks)
        return text

@get('/update_status/<id:int>/<value:int>')
def get_update_status(id, value):
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    #result = db['todo'].find_one(id=id)
    db['todo'].update({'id':id, 'status':(value!=0)},['id'])
    redirect('/')


@get('/delete_item/<id:int>')
def get_delete_item(id):
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    db['todo'].delete(id=id)
    redirect('/')

@get('/clear_completed_tasks')
def get_clear_completed_tasks():
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    db['todo'].delete(status=True)
    redirect('/')


@get('/update_task/<id:int>')
def get_update_task(id):
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    result = db['todo'].find_one(id=id)
    return template("update_task", row=result)


@post('/update_task')
def post_update_task():
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    id = int(request.forms.get("id"))
    updated_task = request.forms.get("updated_task").strip()
    db['todo'].update({'id':id, 'task':updated_task},['id'])
    redirect('/')


@get('/new_item')
def get_new_item():
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    return template("new_item")


@post('/new_item')
def post_new_item():
    session = get_session(request, response)
    if session['username'] == 'Guest':
        redirect('/login')
        return
    new_task = request.forms.get("new_task").strip()
    db['todo'].insert({'task':new_task, 'status':False})
    redirect('/')


if ON_PYTHONANYWHERE:
    TEMPLATE_PATH.insert(0,'C:/Users/Jaimie/Desktop/wp_project/web_programming_i-master/')
    application = default_app()
else:
    debug(True)
    TEMPLATE_PATH.insert(0,'C:/Users/Jaimie/Desktop/wp_project/web_programming_i-master/views')
    run(host="localhost", port=8080)