describe MotionWiretap::Signal do

  before do
    @values = []
    @signal = MotionWiretap::Signal.new(:initial)
    @signal.listen do |value|
      @values << value
    end
    @signal.and_then do
      @done = true
    end
    @signal.on_error do |error|
      @error = error
    end
  end

  it 'should start with initial' do
    @values.should == [:initial]
  end

  it 'should send a value on next()' do
    @signal.next(:next)
    @values.should == [:initial, :next]
  end

  it 'should send multiple values on next()' do
    @signal.next(:a)
    @signal.next(:b)
    @values.should == [:initial, :a, :b]
  end

  it 'should complete' do
    @signal.next(:a)
    @signal.complete
    @done.should == true
  end

  it 'should error' do
    @signal.error(:error)
    @error.should == :error
  end

end
