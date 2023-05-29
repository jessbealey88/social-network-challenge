require 'post_repository'
def reset_posts_table
    seed_sql = File.read('spec/seeds_socialnetwork.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe PostRepository do
    before(:each) do 
      reset_posts_table
    end

    it "returns a list of all posts" do
  
        repo = PostRepository.new

        posts = repo.all
    
        expect(posts.length). to eq  3
    
        expect(posts[0].id).to eq '1'
        expect(posts[0].title).to eq 'post_1'
        expect(posts[0].content).to eq 'some text about stuff'
        expect(posts[0].views).to eq '10'
        expect(posts[0].user_account_id).to eq '1'
    end

    it "returns a single post" do
        repo = PostRepository.new

        post = repo.find(1)

        expect(post.id).to eq '1'
        expect(post.title).to eq 'post_1'
        expect(post.content).to eq'some text about stuff'
        expect(post.views).to eq '10'
        expect(post.user_account_id).to eq '1'
    end

    it "creates a post" do
        repo = PostRepository.new
        new_post = Post.new
        new_post.title ='post_4'
        new_post.content = 'An important announcement'
        new_post.views = '9'
        new_post.user_account_id = '2'
        repo.create(new_post)
        expect(repo.all).to include(
           have_attributes(
           title: new_post.title,
           content: new_post.content,
           views: new_post.views,
           user_account_id: new_post.user_account_id))
    end

    xit "deletes a post" do
        repo = PostRepository.new
        repo.delete(1)
        post = repo.find(1)
        expect(post.length).to eq 0
    end
 end