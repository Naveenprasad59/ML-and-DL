import pandas as pd
import numpy as np
from sklearn.preprocessing import OneHotEncoder
from sklearn.impute import SimpleImputer
from sklearn import metrics
from sklearn import tree
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import GridSearchCV


data = pd.read_csv('train.csv')
# data.info()
target = data['Survived']
data =data.drop('Survived',axis=1)
data.fillna(0,inplace=True)
data = data.drop(['Name','SibSp','Ticket','Cabin','Embarked','Parch','Pclass'],axis=1)
data.fillna(0.0)
data['Sex'].replace('female',0,inplace=True)
data['Sex'].replace('male',1,inplace=True)
clf = DecisionTreeClassifier()
X_train, X_test, y_train, y_test = train_test_split(data,target,test_size=0.33, random_state=42)
clf.fit(X_train,y_train)
predict =clf.predict(X_test)
acc = metrics.accuracy_score(y_test,predict)
print(acc)
parameters ={'criterion' :["gini", "entropy"],
             'splitter': ['best', 'random'],
             'max_features':['auto', 'sqrt', 'log2'],
             'max_depth':[10,20,30]
            }
scorer = metrics.make_scorer(metrics.f1_score)
grid_obj = GridSearchCV(clf,parameters,scoring=scorer)
grid_fit = grid_obj.fit(data,target)
best_clf = grid_fit.best_estimator_
best_clf.fit(X_train,y_train)
predict = best_clf.predict(X_test)
print("Accuracy:",metrics.accuracy_score(y_test,predict))
feature_names = ['PassengerId','Sex','Age','Fare']
class_names = ['not-survived','survived']
fig, axes = plt.subplots(nrows = 1,ncols = 1,figsize = (4,4), dpi=300)
tree.plot_tree(best_clf,feature_names=feature_names,class_names=class_names,filled=True,rounded=True)
fig.savefig('titanic.png')








