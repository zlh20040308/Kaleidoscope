# 编译器和编译选项
CC = clang++
CXXFLAGS = -Wall -Iinclude -MMD -MP -std=c++17

# 目标可执行文件
TARGET = build/app

# 源文件和对象文件路径
SRCDIR = src
BUILDDIR = build
INCDIR = include

# 自动查找 src/ 目录下的所有 .cpp 文件
SRCS = $(wildcard $(SRCDIR)/*.cpp)

# 将源文件对应的目标文件 (.o) 和依赖文件 (.d) 放入 build 目录
OBJS = $(SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)
DEPS = $(OBJS:.o=.d)

# 默认目标是生成可执行文件
all: $(TARGET)

# 确保 build 目录存在
$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

# 最终生成可执行文件的规则，依赖于目标文件
$(TARGET): $(BUILDDIR) $(OBJS)
	@$(CC) $(OBJS) -o $@

# 包含依赖文件（如果存在）
-include $(DEPS)

# 编译规则，将源文件编译为 .o 文件并存放到 build 目录，同时生成 .d 文件
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@$(CC) $(CXXFLAGS) -c $< -o $@

# 清理生成的文件
clean:
	@rm -rf $(BUILDDIR)

# 运行可执行文件
run: $(TARGET)
	@./$(TARGET)

.PHONY: all clean run
