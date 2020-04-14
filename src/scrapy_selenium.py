# Generated by Selenium IDE
import pytest
import time
import json
import re
import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

class TestSavemovie():
  def setup_method(self, method):
    self.driver = webdriver.Chrome()
    self.vars = {}

  def teardown_method(self, method):
    self.driver.quit()

  def test_copytext(self):
    prefx = ''
    db = 'material'
    dblen = 2335
    header = 'event	week'

    self.driver.get("https://sqlzoo.net/wiki/Dressmaker")
    self.driver.set_window_size(1009, 768)
    file = './src/' + prefx + db + '.csv'
    if os.path.exists(file):
      print(file + ' already exists.')
      exit()
    f = open(file, 'a+', encoding='utf-8')
    f.write(re.sub(r'\s', ',', header))
    i = 0
    while i < dblen:
    # while i < 51:
      self.driver.find_element(By.ID, "txtar_1").clear()
      self.driver.find_element(By.ID, "txtar_1").send_keys("SELECT * from %s limit %i, 50" % (db, i))
      self.driver.find_element(By.CSS_SELECTOR, "#frm__1 .submitSQL").click()
      time.sleep(4.5)
      ## web page: MORE_JOIN_operations
      # txt = self.driver.find_element(By.CSS_SELECTOR, ".qu:nth-child(12) > .res").text
      ## Web page: AdventureWorks
      # txt = self.driver.find_element(By.CSS_SELECTOR, ".qu:nth-child(8) > .res").text
      ## Web page: Neeps_easy_questions
      # txt = self.driver.find_element(By.CSS_SELECTOR, ".qu:nth-child(4) > .res").text
      ## Web page: Dressmaker
      txt = self.driver.find_element(By.CSS_SELECTOR, ".qu:nth-child(7) > .res").text
      txt = txt.replace(header, '')
      txt = txt.replace('Result:', '')
      txt = txt.replace('Wrong answer. Too many columns', '')
      txt = txt.replace('Show what the answer should be...', '')
      i += 50
      f.write(re.sub('\n{2,}', '\n', txt))
    f.close()