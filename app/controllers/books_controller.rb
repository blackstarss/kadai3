class BooksController < ApplicationController

  
  def index
    @user = current_user
    
    @book = Book.new
    @books = Book.all
    # .newと記述すると、空のモデルが生成  インスタンス変数を書いた空のモデルを渡すと、フォームとBlogモデルが関連づけられます。
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user  
  end

  
  def create
      
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 
    if @book.save
      
      redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
     @user = current_user
     @books = Book.all
     render :index
  #renderはredirect_toと異なりアクションを経由せず、そのままビューを出力するので、ビューで使う変数は、renderの前にそのアクション`で定義しないといけない。 ここでは@books=Book.allアクションを定義しておく必要
    end
  end
  # 
  


# findメソッドは、idによってモデルを検索してくれるメソッド
# paramsメソッドは、送信された値の受け渡しをするメソッドparams[:カラム]のように書いて、モデルのカラムを指定してあげることで、送信された値のパラメータからその値を取り出してくれます

  def edit
    @book = Book.find(params[:id])
  end
  # インスタンス変数は、同じクラス内であれば、メソッドを抜け出しても使うことができます！
  # 今回は投稿済みのデータを編集するので、保存されているデータが必要。findメソッドを用いて、データを取得
  #Book.find(params[:id])は、送信されたパラメータの中からidカラムを取り出し、そのidをもとにBookモデルを探している

  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      
      render  user_path(current_user.id) 
    end
  end
  # インスタンス変数で定義し直す
  
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    
    redirect_to books_path, data: { confirm: 'Are you sure?' } , notice: "Book was successfully destroyed."
  end
  
  # redirect_toメソッドが実は非常に便利に出来ていて、引数に文字列を渡すことで簡単にflash配列へとメッセージを格納することが可能
  
  protected
  # ストロングパラメータ  privateは一種の境界線で、「ここから下はcontrollerの中でしか呼び出せません」という意味   他のアクション（index,show,createなど）を巻き込まないようにprivateはControllerファイルの一番下のendのすぐ上
  def book_params
    params.require(:book).permit(:title, :body)
    
    # require(:book).を削除した
  end
  
  
end
