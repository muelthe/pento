defmodule Pento.FaqsTest do
  use Pento.DataCase

  alias Pento.Faqs

  describe "questions" do
    alias Pento.Faqs.Question

    import Pento.FaqsFixtures

    @invalid_attrs %{answer: nil, question: nil, vote_count: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Faqs.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Faqs.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{answer: "some answer", question: "some question", vote_count: 42}

      assert {:ok, %Question{} = question} = Faqs.create_question(valid_attrs)
      assert question.answer == "some answer"
      assert question.question == "some question"
      assert question.vote_count == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Faqs.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{answer: "some updated answer", question: "some updated question", vote_count: 43}

      assert {:ok, %Question{} = question} = Faqs.update_question(question, update_attrs)
      assert question.answer == "some updated answer"
      assert question.question == "some updated question"
      assert question.vote_count == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Faqs.update_question(question, @invalid_attrs)
      assert question == Faqs.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Faqs.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Faqs.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Faqs.change_question(question)
    end
  end
end
