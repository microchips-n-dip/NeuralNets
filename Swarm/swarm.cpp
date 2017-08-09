class UnformattedCondition
{
  public:

  // To know whether it is an if or until condition
  // (basically a simple if/for distinction)
  bool prerequisite;
  bool is_satisfied;

  void update_satisfaction_state()
  { }

  bool check_satisfaction()
  {
    (*this).update_satisfaction_state();
    return is_satisfied;
  }
};

#define CONDITION_CLASS(ClassName) class ClassName : public UnformattedCondition

CONDITION_CLASS(IfPositionConditional)
{
  public:

  double* pos;
  double limit;

  IfPositionCobditional(double& _pos, double _limit)
  {
    pos = &_pos;
    limit = _limit;
  }

  void update_satisfaction_state()
  {
    if (*pos == limit) is_satsified = true;
    else is_satisfied = false;
  }
};

class UnformattedTask
{
  public:

  std::vector<conditions_ptr> conditions;
  std::string task_name;
};

#define TASK_CLASS(ClassName) class ClassName : public UnformattedTask

typedef UnformattedTask* task_ptr;

TASK_CLASS(MicroTask)
{

};

TASK_CLASS(SuperTask)
{
  public:

  std::vector<task_ptr> sub_tasks;
  
};
