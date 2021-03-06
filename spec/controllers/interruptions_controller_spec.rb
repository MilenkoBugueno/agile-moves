require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe InterruptionsController do

  # This should return the minimal set of attributes required to create a valid
  # Interruption. As you add validations to Interruption, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "body" => "MyText" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InterruptionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all interruptions as @interruptions" do
      interruption = Interruption.create! valid_attributes
      get :index, {}, valid_session
      assigns(:interruptions).should eq([interruption])
    end
  end

  describe "GET show" do
    it "assigns the requested interruption as @interruption" do
      interruption = Interruption.create! valid_attributes
      get :show, {:id => interruption.to_param}, valid_session
      assigns(:interruption).should eq(interruption)
    end
  end

  describe "GET new" do
    it "assigns a new interruption as @interruption" do
      get :new, {}, valid_session
      assigns(:interruption).should be_a_new(Interruption)
    end
  end

  describe "GET edit" do
    it "assigns the requested interruption as @interruption" do
      interruption = Interruption.create! valid_attributes
      get :edit, {:id => interruption.to_param}, valid_session
      assigns(:interruption).should eq(interruption)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Interruption" do
        expect {
          post :create, {:interruption => valid_attributes}, valid_session
        }.to change(Interruption, :count).by(1)
      end

      it "assigns a newly created interruption as @interruption" do
        post :create, {:interruption => valid_attributes}, valid_session
        assigns(:interruption).should be_a(Interruption)
        assigns(:interruption).should be_persisted
      end

      it "redirects to the created interruption" do
        post :create, {:interruption => valid_attributes}, valid_session
        response.should redirect_to(Interruption.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved interruption as @interruption" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interruption.any_instance.stub(:save).and_return(false)
        post :create, {:interruption => { "body" => "invalid value" }}, valid_session
        assigns(:interruption).should be_a_new(Interruption)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interruption.any_instance.stub(:save).and_return(false)
        post :create, {:interruption => { "body" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested interruption" do
        interruption = Interruption.create! valid_attributes
        # Assuming there are no other interruptions in the database, this
        # specifies that the Interruption created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Interruption.any_instance.should_receive(:update_attributes).with({ "body" => "MyText" })
        put :update, {:id => interruption.to_param, :interruption => { "body" => "MyText" }}, valid_session
      end

      it "assigns the requested interruption as @interruption" do
        interruption = Interruption.create! valid_attributes
        put :update, {:id => interruption.to_param, :interruption => valid_attributes}, valid_session
        assigns(:interruption).should eq(interruption)
      end

      it "redirects to the interruption" do
        interruption = Interruption.create! valid_attributes
        put :update, {:id => interruption.to_param, :interruption => valid_attributes}, valid_session
        response.should redirect_to(interruption)
      end
    end

    describe "with invalid params" do
      it "assigns the interruption as @interruption" do
        interruption = Interruption.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Interruption.any_instance.stub(:save).and_return(false)
        put :update, {:id => interruption.to_param, :interruption => { "body" => "invalid value" }}, valid_session
        assigns(:interruption).should eq(interruption)
      end

      it "re-renders the 'edit' template" do
        interruption = Interruption.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Interruption.any_instance.stub(:save).and_return(false)
        put :update, {:id => interruption.to_param, :interruption => { "body" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested interruption" do
      interruption = Interruption.create! valid_attributes
      expect {
        delete :destroy, {:id => interruption.to_param}, valid_session
      }.to change(Interruption, :count).by(-1)
    end

    it "redirects to the interruptions list" do
      interruption = Interruption.create! valid_attributes
      delete :destroy, {:id => interruption.to_param}, valid_session
      response.should redirect_to(interruptions_url)
    end
  end

end
