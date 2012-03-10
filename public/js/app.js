angular.service('Task', function($resource) {
    return $resource('/tasks', {}, {
        all: {method: 'GET', isArray: true},
        save: {method: 'POST'},
        destroy: {method: 'DELETE'},
        update: {method: 'PUT'}
    });
});

String.prototype.trim = function() {
    return this.replace(/^\s*/, "").replace(/\s*$/, "");
}

function TaskListController(Task) {
    var self = this;
    self.tasks = Task.all();

    this.disabled = true;
    this.addTask = function() {
        this.taskText = this.taskText.trim()
        if(this.taskText == '') 
           return alert('You have to type something');
        var uid = new Date().getTime();
        Task.save({id: uid, name: this.taskText, done: false});
        this.tasks.push({id: uid, name: this.taskText, done: false, partial: false});
        this.taskText = '';
    }

    this.checkDone = function() {
        angular.forEach(this.tasks, function(task) {
            if(task.partial && !task.done) {
                task.name += " (Done)";
                task.done = true;
                Task.update({id: task.id, name: task.name, done: task.partial});
            }
        });
    }

    this.deleteDone = function() {
        this.tasks = this.tasks.filter(function(task) {
            if (!task.done && !task.partial) {
                return !task.done && !task.partial;
            }
            Task.destroy({id: task.id});
        });
    }
}

TaskListController.$inject = ['Task'];
