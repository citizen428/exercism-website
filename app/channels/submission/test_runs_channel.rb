class Submission::TestRunsChannel < ApplicationCable::Channel
  def subscribed
    submission = current_user.submissions.find_by!(uuid: params[:submission_uuid])
    stream_for submission
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast!(test_run)
    broadcast_to test_run.submission,
      test_run: SerializeSubmissionTestRun.(test_run)
  end
end
