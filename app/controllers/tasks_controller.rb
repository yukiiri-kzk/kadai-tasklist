class TasksController < ApplicationController
  #indexアクション（メソッド）はTaskモデルの一覧表示を取得する
  #indexアクションはTaskモデルのレコード（tasklist_developmentデータベースのtasksテーブルのレコードを取得したもの）の一覧表示をする役割
  #@tasksにするのは、@tasksというインスタンス変数を経由することで Controller から View へ変数を渡すことができるから
  def index 
    @tasks = Task.all
  end
    
  #show アクション（詳細ページへのアクセス）には :id の引数が与えられている
  #rails routesより:id があることを確認する
  #paramsメソッドでURLから送られてきた値やフォームで入力した値を受け取る
  def show
    @task = Task.find(params[:id])
  end
  
  #newアクションはPOSTメソッドを送信する新規作成用の入力フォーム置き場
  def new
    @task = Task.new
  end
  
  #createアクションは保存アクション
  #保存アクション(create)にデータを送るには、新規作成用のフォームページ(new)が必要
  #ハッシュは配列と同じく複数のオブジェクトへの参照をまとめて管理することが出来るオブジェクト
  #flash はハッシュなので、{ success: 'Message が正常に投稿されました' } という形で保存される
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが作成されませんでした'
      render :new
    end
  end
  
  #editアクションは更新用のフォームページの追加
  def edit
    @task = Task.find(params[:id])
  end
  
  #updateは更新アクション
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end
    
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  
  #Strong Parameter
  #送信されてきたデータを精査（フィルタリング）する
  #params.require(:task)でtaskモデルのフォームから得られるデータに関するものだと明示
  #permit(:content)でカラムを指定
  def task_params
    params.require(:task).permit(:content)
  end
end